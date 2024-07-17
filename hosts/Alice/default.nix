{username, ...}: {
  stylix.image = ./wp-desert.jpg;
  darwin.dock = {
    browser = "Chrome";
    apps = [
      "/Applications/Slack.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/zoom.us.app"
    ];
  };

  # TODO: Try to use the version packaged in nixpkgs instead
  homebrew.brews = ["awscli"];

  home-manager.users.${username} = {
    code.codium = {
      rust = false;
      java = true;
    };
  };
}
