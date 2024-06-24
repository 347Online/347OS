{username, ...}: {
  darwin.dock = {
    browser = "Chrome";
    apps = [
      "/Applications/Slack.app"
      "/Applications/Microsoft Outlook.app"
      "/Applications/zoom.us.app"
    ];
  };

  home-manager.users.${username} = {
    lang.java.enable = true;
  };
}
