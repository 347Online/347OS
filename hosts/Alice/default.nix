{
  username,
  pkgs,
  vscode-extensions,
  ...
}:
{
  darwin.dock = {
    browser = "Firefox";
    apps = [
      "/Applications/Slack.app"
    ];
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [ awscli2 ];
    user.codium.extraExtensions = with vscode-extensions; [
    ];
  };
}
