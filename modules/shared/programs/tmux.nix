{
  inputs,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    shortcut = "Space";
    terminal = "xterm-256color"; # TODO: This needs to be set to an environment var or something for correct behavior in tty
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = power-theme;
        extraConfig = "set -g @tmux_power_theme 'default'";
      }
      {
        plugin = battery;
        extraConfig = "set -g status-right '#{battery_status_bg} Batt: #{battery_icon} #{battery_percentage} #{battery_remain} | '";
      }
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
  };
}
