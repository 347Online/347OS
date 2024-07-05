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
    terminal = "xterm-256color";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = power-theme;
        # plugin = catppuccin;
        # extraConfig = "set -g @catppuccin_flavour 'mocha'";
        # plugin = pkgs.tmuxplugins.mktmuxplugin {
        #   name = "catpuccin-tmux-dreamsofcode";
        #   pluginname = "catpuccin-tmux-dreamsofcode";
        #   src = inputs.catpuccin-tmux;
        #   postinstall = ''
        #     sed -i -e 's|''${plugin_dir}/catppuccin-selected-theme.tmuxtheme|''${tmux_tmpdir}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
        #   '';
        # };
      }
    ];
  };
}
