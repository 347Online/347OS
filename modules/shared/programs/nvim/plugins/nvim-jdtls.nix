{homeDirectory, ...}: {
  plugins.nvim-jdtls = {
    enable = true;
    data = "${homeDirectory}/.local/share/jdtls-workspace";
  };
}
