package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"path"
	"sort"
	"strings"

	"golang.org/x/net/html"
)

type Package struct {
	Path     string
	Revision string
	Origin   string
}

type Packages []Package

func (p Packages) Len() int           { return len(p) }
func (p Packages) Less(i, j int) bool { return p[i].Path < p[j].Path }
func (p Packages) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

type VendorData struct {
	Package Packages
}

func ParseVendorData(vendorFile string) (*VendorData, error) {
	f, err := os.Open(vendorFile)
	if err != nil {
		return nil, errors.New("Could not read vendor file")
	}
	defer f.Close()
	vendorData := new(VendorData)
	jsonDecoder := json.NewDecoder(f)
	if err := jsonDecoder.Decode(vendorData); err != nil {
		return nil, errors.New("Could not unmarshal vendor file")
	}
	sort.Sort(vendorData.Package)
	return vendorData, nil
}

func findMeta(doc *html.Node) (repo, location string) {
	var f func(*html.Node)
	f = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "meta" {
			for _, attr := range n.Attr {
				if attr.Key == "name" && attr.Val == "go-import" {
					for _, attr := range n.Attr {
						if attr.Key == "content" {
							repoInfo := strings.Split(attr.Val, " ")
							if repoInfo[1] != "git" {
								return
							}
							repo = repoInfo[0]
							location = repoInfo[2]
							if !strings.HasSuffix(location, ".git") {
								location += ".git"
							}
							return
						}
					}
				}
			}
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			f(c)
		}
	}
	f(doc)
	return
}

func GetRepo(pkg string) (name, url string, err error) {
	switch strings.Split(pkg, "/")[0] {
	case "github.com", "bitbucket.org":
		name = strings.Join(strings.Split(pkg, "/")[:3], "/")
		url = "https://" + name + ".git"
	default:
		res, err := http.Get("https://" + pkg + "?go-get=1")
		if err != nil {
			return name, url, err
		}
		defer res.Body.Close()
		doc, err := html.Parse(res.Body)
		if err != nil {
			return name, url, err
		}
		name, url = findMeta(doc)
	}
	return
}

type repo struct {
	path     string
	name     string
	location string
	revision string
}

func main() {
	if len(os.Args) != 2 {
		log.Fatal("Usage: vendors [path]")
	}

	pkg := os.Args[1]
	vendorData, err := ParseVendorData(path.Join(os.Getenv("GOPATH"), "src", pkg, "vendor/vendor.json"))
	if err != nil {
		log.Fatal(err)
	}

	repos := make(map[string]*repo)

nextRepo:
	for _, pkg := range vendorData.Package {
		for _, repo := range repos {
			if strings.HasPrefix(pkg.Path, repo.name) {
				continue nextRepo
			}
		}
		name, location, err := GetRepo(pkg.Path)
		if err != nil {
			log.Print(err)
			continue
		}
		repo := &repo{
			path:     pkg.Path,
			name:     name,
			location: location,
			revision: pkg.Revision,
		}
		if pkg.Origin != "" {
			_, location, err := GetRepo(pkg.Origin)
			if err != nil {
				log.Print(err)
				continue
			}
			repo.location = location
		}
		repos[repo.name] = repo
	}

	var names []string
	for name := range repos {
		names = append(names, name)
	}
	sort.Strings(names)
	for _, name := range names {
		repo := repos[name]
		fmt.Printf(`  go_resource "%s" do
    url "%s", :revision => "%s"
  end
`, repo.name, repo.location, repo.revision)
	}
}
