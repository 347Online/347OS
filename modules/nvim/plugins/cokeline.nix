{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    nvim-cokeline
  ];
}
