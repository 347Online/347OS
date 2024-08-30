{
  username,
  pkgs,
  ...
}: {
  stylix.image = ./wp-desert.jpg;
  darwin.dock = {
    browser = "Arc";
    apps = [
      "/Applications/Slack.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/zoom.us.app"
    ];
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [awscli2];
    code.codium = {
      rust = false;
      java = true;
    };
  };
}
