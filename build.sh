#!/bin/bash

# Usage
# #####
# 
# 1. Make sure you have cloned the main ttn repo to the correct path (see https://github.com/TheThingsNetwork/ttn)
# 2. Run ./build.sh
# 3. Set the bottle in the Formula
#

set -e

function buildFormula() {
cd $GOPATH/src/github.com/TheThingsNetwork/ttn

git_branch=$(git rev-parse --abbrev-ref HEAD)
git_commit=$(git rev-parse HEAD)

wget https://github.com/TheThingsNetwork/ttn/archive/$git_commit.zip
sha_256=$(shasum -a 256 "$git_commit.zip" | awk '{print $1}')
rm $git_commit.zip

cat <<EOF
require "language/go"

class Ttnctl < Formula
  desc "Command line interface to The Things Network"
  homepage "https://www.thethingsnetwork.org/docs/cli/"
  url "https://github.com/TheThingsNetwork/ttn/archive/$git_commit.zip"
  sha256 "$sha_256"
  version "$git_branch-$git_commit"

  depends_on "go" => :build

EOF

node <<EOF
var execSync = require('child_process').execSync
var vendor = require('./vendor/vendor.json');
var hashes = [];
console.log("  ttn_deps = %w[");
vendor.package.forEach(function(pkg){
  if (hashes.includes(pkg.revision)) {
    return;
  }
  var path = pkg.path.split("/", 3).slice(0,3).join("/");
  var repo = execSync("cd $GOPATH/src/" + path + " && git remote get-url origin").toString().trim();
  console.log("    " + path + " " + repo + " " + pkg.revision);
  hashes.push(pkg.revision);
});
console.log("  ]");
EOF

govendor_commit=$(cd $GOPATH/src/github.com/kardianos/govendor && git rev-parse HEAD)

cat <<EOF

  ttn_deps.each_slice(3) do |path, repo, revision|
    go_resource path do
      url "#{repo}.git", :revision => revision
    end
  end

  go_resource "github.com/kardianos/govendor" do
    url "https://github.com/kardianos/govendor.git", :revision => "$govendor_commit"
  end

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"

    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"
    (gopath/"src/github.com/TheThingsNetwork/ttn").install contents
    ENV["GOROOT_FINAL"] = "/goroot"

    Language::Go.stage_deps resources, gopath/"src"

    cd gopath/"src/github.com/kardianos/govendor" do
      system "go install"
    end

    cd gopath/"src/github.com/TheThingsNetwork/ttn" do
      system "go build -tags homebrew -a -installsuffix cgo -ldflags \"-w -X main.gitBranch=$git_branch -X main.gitCommit=$git_commit -X main.buildDate=\`date -u +%Y-%m-%dT%H:%M:%SZ\`\" -o #{buildpath}/ttnctl ./ttnctl/main.go"
    end

    bin.install "ttnctl"
  end

  test do
    system "#{bin}/ttnctl", "--version"
  end
end
EOF
}

buildFormula > Formula/ttnctl.rb

brew uninstall -f ttnctl

brew install --build-bottle TheThingsNetwork/ttn/ttnctl

brew bottle TheThingsNetwork/ttn/ttnctl
