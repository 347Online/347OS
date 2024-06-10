{username, ...}: {
  darwin.dockApps = [
    "/Applications/Slack.app"
    "/Applications/Microsoft Outlook.app"
    "/Applications/zoom.us.app"
    "/Applications/Fantastical.app"
  ];
  home-manager.users.${username} = {
    lang.java.enable = true;
  };
}