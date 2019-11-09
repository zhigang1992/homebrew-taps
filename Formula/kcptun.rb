class Kcptun < Formula
  desc 'A Fast & Secure Tunnel Based On KCP with N:M Multiplexing'
  homepage 'https://github.com/xtaci/kcptun'
  url 'https://github.com/xtaci/kcptun/releases/download/v20191109/kcptun-darwin-amd64-20191109.tar.gz'
  sha256 '335ccf41a096ece1f5230d464613497908a74649acb3281268b6f5d1d3343776'

  bottle :unneeded

  def install
    bin.install 'client_darwin_amd64' => 'kcptun-client'
    bin.install 'server_darwin_amd64' => 'kcptun-server'
  end

  test do
    system "#{bin}/kcptun-client", '--version'
    system "#{bin}/kcptun-server", '--version'
  end
end

