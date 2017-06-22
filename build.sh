#!/bin/bash

# Usage
# #####
# 
# 1. Make sure you have cloned the main ttn repo to the correct path (see https://github.com/TheThingsNetwork/ttn)
# 2. Run ./build.sh [tag]
# 3. Set the bottle in the Formula
#

set -e

repo=https://github.com/TheThingsNetwork/ttn

govendor_git_commit=$(cd $GOPATH/src/github.com/kardianos/govendor && git rev-parse HEAD)
ttn_git_tag=${1:-$(cd $GOPATH/src/github.com/TheThingsNetwork/ttn && git describe --abbrev=0 --tags 2>/dev/null)}

echo "▶ Generating for $ttn_git_tag..."

ttn_src_url=$repo/archive/$ttn_git_tag.tar.gz

echo "▶ Calculating shasum for $ttn_src_url..."

ttn_src_shasum=$(curl -fsSL $ttn_src_url | shasum -a 256 | awk '{print $1}')

cat <<EOF > Formula/ttnctl.rb
require "language/go"

class Ttnctl < Formula
  desc "Command-line interface to The Things Network"
  homepage "https://www.thethingsnetwork.org/docs/network/cli/"
  url "$ttn_src_url"
  sha256 "$ttn_src_shasum"
  head "$repo.git"

  depends_on "go" => :build

  go_resource "github.com/kardianos/govendor" do
    url "https://github.com/kardianos/govendor.git", :revision => "$govendor_git_commit"
  end

EOF

echo "▶ Adding vendors to Formula..."

go run util/vendors/vendors.go github.com/TheThingsNetwork/ttn >> Formula/ttnctl.rb

cat <<EOF >> Formula/ttnctl.rb

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOROOT_FINAL"] = "/go"

    mkdir_p "src/github.com/TheThingsNetwork"
    ln_s buildpath, "src/github.com/TheThingsNetwork/ttn"

    mkdir_p ".cache"
    ln_s buildpath/"src", ".cache/govendor"

    Language::Go.stage_deps resources, buildpath/"src"

    cd "src/github.com/kardianos/govendor" do
      system "go", "install"
    end

    cd "src/github.com/TheThingsNetwork/ttn" do
      ENV["PWD"] = buildpath/"src/github.com/TheThingsNetwork/ttn"              # govendor is easily confused
      system "bin/govendor", "sync"                                             # make sure the vendors are exactly as in vendor.json

      ldflags = "-w -X main.version=$ttn_git_tag -X main.gitBranch= -X main.gitCommit=homebrew -X main.buildDate=#{Time.now.utc.strftime "%Y-%m-%dT%H:%M:%SZ"}"
      system "go", "build", "-a", "-installsuffix", "cgo", "-tags", "homebrew prod", "-ldflags", ldflags, "-o", "bin/ttnctl", "./ttnctl/main.go"
    end

    bin.install "bin/ttnctl"
  end

  test do
    system bin/"ttnctl", "version"
  end
end
EOF

echo "▶ Uninstalling old ttnctl..."

brew uninstall -f ttnctl

echo "▶ Checking Formula..."

brew audit --new-formula TheThingsNetwork/ttn/ttnctl

echo "▶ Installing Formula..."

brew install --verbose --debug --build-bottle TheThingsNetwork/ttn/ttnctl

echo "▶ Testing Formula..."

brew test TheThingsNetwork/ttn/ttnctl

echo "▶ Bottling Formula..."

brew bottle TheThingsNetwork/ttn/ttnctl

echo "▶ Done"
