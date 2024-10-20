{
  self,
  username,
  pkgs,
  vscode-extensions,
  ...
}: {
  stylix.image = "${self}/wallpapers/desert.jpg";

  darwin.dock = {
    browser = "Safari";
    apps = [
      "/Applications/Slack.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/zoom.us.app"
    ];
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [awscli2];
    shared.codium.extraExtensions = with vscode-extensions; [
      open-vsx.redhat.java
      open-vsx.vscjava.vscode-java-debug
      open-vsx.vscjava.vscode-java-test
      open-vsx.vscjava.vscode-maven
      open-vsx.vscjava.vscode-gradle
      open-vsx.vscjava.vscode-java-dependency
    ];
  };
}
