class Pyright < Formula
  desc "Static type checker for Python"
  homepage "https://github.com/microsoft/pyright"
  url "https://registry.npmjs.org/pyright/-/pyright-1.1.384.tgz"
  sha256 "e14e5c6842def12e5acd6383a2251c6ec17ad77650c5f1fefdade88bfa3f1d9d"
  license "MIT"
  head "https://github.com/microsoft/pyright.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "43f01fc8ac09b780f8c65d3adc8f3493ac8f033cdb4beab250a4f63287a18653"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "43f01fc8ac09b780f8c65d3adc8f3493ac8f033cdb4beab250a4f63287a18653"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "43f01fc8ac09b780f8c65d3adc8f3493ac8f033cdb4beab250a4f63287a18653"
    sha256 cellar: :any_skip_relocation, sonoma:        "cdfe16a3ebbc12a871ee25eca43b626b0d8d754bc5ce95211e025cb0011c523f"
    sha256 cellar: :any_skip_relocation, ventura:       "cdfe16a3ebbc12a871ee25eca43b626b0d8d754bc5ce95211e025cb0011c523f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43f01fc8ac09b780f8c65d3adc8f3493ac8f033cdb4beab250a4f63287a18653"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"broken.py").write <<~EOS
      def wrong_types(a: int, b: int) -> str:
          return a + b
    EOS
    output = pipe_output("#{bin}/pyright broken.py 2>&1")
    assert_match "error: Type \"int\" is not assignable to return type \"str\"", output
  end
end
