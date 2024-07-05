{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = actions-preview-nvim;
      config = '''';
    }
  ];

  keymaps = [
    {
      mode = ["v" "n"];
      key = "<leader>a";
      action.__raw =
        /*
        lua
        */
        ''
          require("actions-preview").code_actions
        '';
    }
  ];
}
