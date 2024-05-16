{pkgs, ...}: {
  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 40;
    x11.enable = true;
    gtk.enable = true;
  };
}
