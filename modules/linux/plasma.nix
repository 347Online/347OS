{ username, ... }:
{
  home-manager.users.${username} = {
    programs.plasma = {
      enable = true;
    };
  };
}
