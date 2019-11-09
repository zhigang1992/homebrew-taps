class Kcptun < Formula
  desc 'A Fast & Secure Tunnel Based On KCP with N:M Multiplexing'
  homepage 'https://github.com/xtaci/kcptun'
  url 'https://github.com/xtaci/kcptun/releases/download/v20191109/kcptun-darwin-amd64-20191109.tar.gz'
  sha256 '335ccf41a096ece1f5230d464613497908a74649acb3281268b6f5d1d3343776'

  bottle :unneeded

  def install
    bin.install 'client_darwin_amd64' => 'kcptun-client'
    bin.install 'server_darwin_amd64' => 'kcptun-server'

    (buildpath/"kcptun-client.json").write <<~EOS
      {
        "remoteaddr": "20.40.13.13:4000",
        "localaddr": ":8388",
        "mode": "fast3",
        "nocomp": true,
        "autoexpire": 900,
        "sockbuf": 16777217,
        "dscp": 46
      }
    EOS
    etc.install "kcptun-client.json"

  end

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/kcptun-client</string>
          <string>-c</string>
          <string>#{etc}/kcptun-client.json</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
  EOS
  end

  test do
    system "#{bin}/kcptun-client", '--version'
    system "#{bin}/kcptun-server", '--version'
  end
end

