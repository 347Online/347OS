{
  pkgs,
  lib,
  util,
  homeDirectory,
  ...
}:
{
  plugins.nvim-jdtls =
    let
      workspace_dir = "${homeDirectory}/.local/share/nvim/jdtls-workspace";
      configuration =
        util.mkIfElse pkgs.stdenv.isDarwin "${workspace_dir}/config_mac"
          "${workspace_dir}/config_linux";
    in
    {
      enable = true;
      cmd = [
        (lib.getExe pkgs.jdt-language-server)
        "-data"
        workspace_dir
        "-configuration"
        configuration
        "--jvm-arg=-javaagent:${pkgs.lombok}/share/java/lombok.jar"
      ];
    };
}
