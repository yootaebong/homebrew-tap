cask "logroom" do
  version "0.17.0"
  sha256 "158b459e5a3a6cde53147d286a7b6ead16eaecf1985d22a956f5b86c780bf1cc"

  url "https://releases.logroom.app/#{version}/LogRoom_#{version}_aarch64.dmg"
  name "LogRoom"
  desc "Local-only activity logger with parallel timelines and AI summaries"
  homepage "https://logroom.app/"

  livecheck do
    url "https://releases.logroom.app/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on :macos

  app "LogRoom.app"

  # Not notarized: drop the quarantine flag so Gatekeeper does not block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/LogRoom.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/app.logroom.desktop",
    "~/Library/Application Support/LogRoom",
    "~/Library/Caches/app.logroom.desktop",
    "~/Library/Preferences/app.logroom.desktop.plist",
    "~/Library/WebKit/app.logroom.desktop",
  ]
end
