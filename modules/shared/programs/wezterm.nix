{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      return {
        initial_cols = 100,
        initial_rows = 40,
        window_close_confirmation = 'NeverPrompt',
        hide_tab_bar_if_only_one_tab = true
      }
    '';
  };
}
