{
  util,
  isDarwin,
  homeDirectory,
  ...
}: {
  plugins.nvim-jdtls = let
    workspace_dir = "${homeDirectory}/.local/share/nvim/jdtls-workspace";
    configuration =
      util.mkIfElse isDarwin
      "${workspace_dir}/config_mac"
      "${workspace_dir}/config_linux";
  in {
    enable = true;
    data.__raw =
      # lua
      ''
        '${workspace_dir}/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      '';
    inherit configuration;
  };
}
