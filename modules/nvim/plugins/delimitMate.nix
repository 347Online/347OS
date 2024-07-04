{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    delimitMate
  ];

  globals = {
    delimitMate_expand_cr = true;
    delimitMate_expand_inside_quotes = true;
    delimitMate_autoclose = false;
    delimitMate_balance_matchpairs = false;
  };
}
