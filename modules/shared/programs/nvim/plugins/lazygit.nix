{util, ...}: {
  plugins.lazygit = {
    enable = true;
  };

  keymaps = [
    (util.vimBind "n" "<leader>gg" ":LazyGit<CR>")
  ];
}
