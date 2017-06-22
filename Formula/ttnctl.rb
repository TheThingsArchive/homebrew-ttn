require "language/go"

class Ttnctl < Formula
  desc "Command-line interface to The Things Network"
  homepage "https://www.thethingsnetwork.org/docs/network/cli/"
  url "https://github.com/TheThingsNetwork/ttn/archive/v2.7.1.tar.gz"
  sha256 "94744bf5bad338fe7f80cb78cd2ab461c89ea65255f400eb674fa7a8b59a162d"
  head "https://github.com/TheThingsNetwork/ttn.git"

  depends_on "go" => :build

  go_resource "github.com/kardianos/govendor" do
    url "https://github.com/kardianos/govendor.git", :revision => "c86c10d612bf08e847456ce91d495eb69ad87087"
  end

  go_resource "github.com/StackExchange/wmi" do
    url "https://github.com/StackExchange/wmi.git", :revision => "ea383cf3ba6ec950874b8486cd72356d007c768f"
  end
  go_resource "github.com/TheThingsNetwork/go-account-lib" do
    url "https://github.com/TheThingsNetwork/go-account-lib.git", :revision => "c3634eb20045e94abd340fac873c3be17e506e36"
  end
  go_resource "github.com/TheThingsNetwork/go-cayenne-lib" do
    url "https://github.com/TheThingsNetwork/go-cayenne-lib.git", :revision => "b93f1e68bb8083a2b95c7149fe3b51fc595a717f"
  end
  go_resource "github.com/TheThingsNetwork/go-utils" do
    url "https://github.com/TheThingsNetwork/go-utils.git", :revision => "7f35a9fdb4de6692822ef259a23d4964483f3a8c"
  end
  go_resource "github.com/apex/log" do
    url "https://github.com/apex/log.git", :revision => "7259ed75bd8d8113a7ac9831ecb0558cac33ceed"
  end
  go_resource "github.com/asaskevich/govalidator" do
    url "https://github.com/asaskevich/govalidator.git", :revision => "065ea97278837088c52c0cd0d963473f61b2d98c"
  end
  go_resource "github.com/bluele/gcache" do
    url "https://github.com/bluele/gcache.git", :revision => "b9993a9fff7b10a1fd0404d8aa4a039cb625534d"
  end
  go_resource "github.com/brocaar/lorawan" do
    url "https://github.com/brocaar/lorawan.git", :revision => "c61721fa96c85c25ea7ba635fc477224344ddbe3"
  end
  go_resource "github.com/cpuguy83/go-md2man" do
    url "https://github.com/cpuguy83/go-md2man.git", :revision => "23709d0847197db6021a51fdb193e66e9222d4e7"
  end
  go_resource "github.com/dgrijalva/jwt-go" do
    url "https://github.com/dgrijalva/jwt-go.git", :revision => "6c8dedd55f8a2e41f605de6d5d66e51ed1f299fc"
  end
  go_resource "github.com/eclipse/paho.mqtt.golang" do
    url "https://github.com/eclipse/paho.mqtt.golang.git", :revision => "c37a0a275c2de30bf1c7eb072dd6bef09a93c666"
  end
  go_resource "github.com/fatih/structs" do
    url "https://github.com/fatih/structs.git", :revision => "a720dfa8df582c51dee1b36feabb906bde1588bd"
  end
  go_resource "github.com/fsnotify/fsnotify" do
    url "https://github.com/fsnotify/fsnotify.git", :revision => "4da3e2cfbabc9f751898f250b49f2439785783a1"
  end
  go_resource "github.com/go-ole/go-ole" do
    url "https://github.com/go-ole/go-ole.git", :revision => "de8695c8edbf8236f30d6e1376e20b198a028d42"
  end
  go_resource "github.com/gogo/protobuf" do
    url "https://github.com/gogo/protobuf.git", :revision => "30433562cfbf487fe1df7cd26c7bab168d2f14d0"
  end
  go_resource "github.com/golang/mock" do
    url "https://github.com/golang/mock.git", :revision => "bd3c8e81be01eef76d4b503f5e687d2d1354d2d9"
  end
  go_resource "github.com/golang/protobuf" do
    url "https://github.com/golang/protobuf.git", :revision => "fec3b39b059c0f88fa6b20f5ed012b1aa203a8b4"
  end
  go_resource "github.com/gosuri/uitable" do
    url "https://github.com/gosuri/uitable.git", :revision => "36ee7e946282a3fb1cfecd476ddc9b35d8847e42"
  end
  go_resource "github.com/grpc-ecosystem/grpc-gateway" do
    url "https://github.com/grpc-ecosystem/grpc-gateway.git", :revision => "f6f92fcd9cdd44baa8425a1b27d181b614d0da1b"
  end
  go_resource "github.com/hashicorp/hcl" do
    url "https://github.com/hashicorp/hcl.git", :revision => "392dba7d905ed5d04a5794ba89f558b27e2ba1ca"
  end
  go_resource "github.com/howeyc/gopass" do
    url "https://github.com/howeyc/gopass.git", :revision => "bf9dde6d0d2c004a008c27aaee91170c786f6db8"
  end
  go_resource "github.com/htdvisser/grpc-testing" do
    url "https://github.com/htdvisser/grpc-testing.git", :revision => "f0a186b6b52b6987645cf6e35a422d6bd7fcac8f"
  end
  go_resource "github.com/inconshreveable/mousetrap" do
    url "https://github.com/inconshreveable/mousetrap.git", :revision => "76626ae9c91c4f2a10f34cad8ce83ea42c93bb75"
  end
  go_resource "github.com/jacobsa/crypto" do
    url "https://github.com/jacobsa/crypto.git", :revision => "293ce0c192fb4f59cd879b46544922b9ed09a13a"
  end
  go_resource "github.com/juju/ratelimit" do
    url "https://github.com/juju/ratelimit.git", :revision => "acf38b000a03e4ab89e40f20f1e548f4e6ac7f72"
  end
  go_resource "github.com/kardianos/osext" do
    url "https://github.com/kardianos/osext.git", :revision => "ae77be60afb1dcacde03767a8c37337fad28ac14"
  end
  go_resource "github.com/magiconair/properties" do
    url "https://github.com/magiconair/properties.git", :revision => "51463bfca2576e06c62a8504b5c0f06d61312647"
  end
  go_resource "github.com/mattn/go-runewidth" do
    url "https://github.com/mattn/go-runewidth.git", :revision => "97311d9f7767e3d6f422ea06661bc2c7a19e8a5d"
  end
  go_resource "github.com/mitchellh/go-homedir" do
    url "https://github.com/mitchellh/go-homedir.git", :revision => "b8bc1bf767474819792c23f32d8286a45736f1c6"
  end
  go_resource "github.com/mitchellh/mapstructure" do
    url "https://github.com/mitchellh/mapstructure.git", :revision => "cc8532a8e9a55ea36402aa21efdf403a60d34096"
  end
  go_resource "github.com/mwitkow/go-grpc-middleware" do
    url "https://github.com/mwitkow/go-grpc-middleware.git", :revision => "fb1b862bbda2067865911d847adb45124329afa2"
  end
  go_resource "github.com/pelletier/go-buffruneio" do
    url "https://github.com/pelletier/go-buffruneio.git", :revision => "c37440a7cf42ac63b919c752ca73a85067e05992"
  end
  go_resource "github.com/pelletier/go-toml" do
    url "https://github.com/pelletier/go-toml.git", :revision => "685a1f1cb7a66b9cadbe8f1ac49d9f8f567d6a9d"
  end
  go_resource "github.com/pkg/errors" do
    url "https://github.com/pkg/errors.git", :revision => "c605e284fe17294bda444b34710735b29d1a9d90"
  end
  go_resource "github.com/rcrowley/go-metrics" do
    url "https://github.com/rcrowley/go-metrics.git", :revision => "1f30fe9094a513ce4c700b9a54458bbb0c96996c"
  end
  go_resource "github.com/robertkrimen/otto" do
    url "https://github.com/htdvisser/otto.git", :revision => "4c9f00e2ef7b56d46b9c699c30b94ad93f348dae"
  end
  go_resource "github.com/russross/blackfriday" do
    url "https://github.com/russross/blackfriday.git", :revision => "067529f716f4c3f5e37c8c95ddd59df1007290ae"
  end
  go_resource "github.com/shirou/gopsutil" do
    url "https://github.com/shirou/gopsutil.git", :revision => "b6da2bd76e7d66a228181f7993265cf859d5351f"
  end
  go_resource "github.com/shirou/w32" do
    url "https://github.com/shirou/w32.git", :revision => "bb4de0191aa41b5507caa14b0650cdbddcd9280b"
  end
  go_resource "github.com/shurcooL/sanitized_anchor_name" do
    url "https://github.com/shurcooL/sanitized_anchor_name.git", :revision => "541ff5ee47f1dddf6a5281af78307d921524bcb5"
  end
  go_resource "github.com/smartystreets/assertions" do
    url "https://github.com/smartystreets/assertions.git", :revision => "f8459f92181409546d2762c9e9c4bedc23c92d76"
  end
  go_resource "github.com/smartystreets/go-aws-auth" do
    url "https://github.com/smartystreets/go-aws-auth.git", :revision => "8ef1316913ee4f44bc48c2456e44a5c1c68ea53b"
  end
  go_resource "github.com/spf13/afero" do
    url "https://github.com/spf13/afero.git", :revision => "9be650865eab0c12963d8753212f4f9c66cdcf12"
  end
  go_resource "github.com/spf13/cast" do
    url "https://github.com/spf13/cast.git", :revision => "acbeb36b902d72a7a4c18e8f3241075e7ab763e4"
  end
  go_resource "github.com/spf13/cobra" do
    url "https://github.com/spf13/cobra.git", :revision => "31694f19adeeaeb0a0e5fe95441b390d757753d2"
  end
  go_resource "github.com/spf13/jwalterweatherman" do
    url "https://github.com/spf13/jwalterweatherman.git", :revision => "8f07c835e5cc1450c082fe3a439cf87b0cbb2d99"
  end
  go_resource "github.com/spf13/pflag" do
    url "https://github.com/spf13/pflag.git", :revision => "e57e3eeb33f795204c1ca35f56c44f83227c6e66"
  end
  go_resource "github.com/spf13/viper" do
    url "https://github.com/spf13/viper.git", :revision => "0967fc9aceab2ce9da34061253ac10fb99bba5b2"
  end
  go_resource "github.com/streadway/amqp" do
    url "https://github.com/streadway/amqp.git", :revision => "6063341da5df18c5abcb1f62373016ab9858b7b0"
  end
  go_resource "github.com/tj/go-elastic" do
    url "https://github.com/tj/go-elastic.git", :revision => "9a9a2a21e071e6e38f236740c3b650e7316ae67e"
  end
  go_resource "golang.org/x/crypto" do
    url "https://go.googlesource.com/crypto.git", :revision => "ab89591268e0c8b748cbe4047b00197516011af5"
  end
  go_resource "golang.org/x/net" do
    url "https://go.googlesource.com/net.git", :revision => "84f0e6f92b10139f986b1756e149a7d9de270cdc"
  end
  go_resource "golang.org/x/oauth2" do
    url "https://go.googlesource.com/oauth2.git", :revision => "ad516a297a9f2a74ecc244861b298c94bdd28b9d"
  end
  go_resource "golang.org/x/sys" do
    url "https://go.googlesource.com/sys.git", :revision => "1e99a4f9d247b28c670884b9a8d6801f39a47b77"
  end
  go_resource "golang.org/x/text" do
    url "https://go.googlesource.com/text.git", :revision => "19e51611da83d6be54ddafce4a4af510cb3e9ea4"
  end
  go_resource "google.golang.org/appengine" do
    url "https://github.com/golang/appengine.git", :revision => "170382fa85b10b94728989dfcf6cc818b335c952"
  end
  go_resource "google.golang.org/genproto" do
    url "https://github.com/google/go-genproto.git", :revision => "411e09b969b1170a9f0c467558eb4c4c110d9c77"
  end
  go_resource "google.golang.org/grpc" do
    url "https://github.com/grpc/grpc-go.git", :revision => "1c69e4cae0f5180ce7d8b472bf0a55d2654fe31b"
  end
  go_resource "gopkg.in/redis.v5" do
    url "https://gopkg.in/redis.v5.git", :revision => "a16aeec10ff407b1e7be6dd35797ccf5426ef0f0"
  end
  go_resource "gopkg.in/sourcemap.v1" do
    url "https://gopkg.in/sourcemap.v1.git", :revision => "6e83acea0053641eff084973fee085f0c193c61a"
  end
  go_resource "gopkg.in/yaml.v2" do
    url "https://gopkg.in/yaml.v2.git", :revision => "cd8b52f8269e0feb286dfeef29f8fe4d5b397e0b"
  end

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

      ldflags = "-w -X main.version=v2.7.1 -X main.gitBranch= -X main.gitCommit=homebrew -X main.buildDate=#{Time.now.utc.strftime "%Y-%m-%dT%H:%M:%SZ"}"
      system "go", "build", "-a", "-installsuffix", "cgo", "-tags", "homebrew prod", "-ldflags", ldflags, "-o", "bin/ttnctl", "./ttnctl/main.go"
    end

    bin.install "bin/ttnctl"
  end

  test do
    system bin/"ttnctl", "version"
  end
end
