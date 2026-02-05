{
  username,
  pkgs,
  ...
}:
{
  darwin = {
    dock = {
      email.enable = false;
      apps = [
        "/Applications/Slack.app"
      ];
    };
  };

  homebrew = {
    taps = [
      "amplify-education/astrotools"
    ];

    brews = [
      "awscli"
      "amplify-education/astrotools/meta"
      "docker-credential-helper-ecr"
      "nginx"
      "opa"
      "pipx"
      "pyenv"
      "pyenv-virtualenv"
    ];

    casks = [
      "dbeaver-community"
      "docker-desktop"
    ];
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      nodemon
      tflint
      tfupdate
      yarn
    ];
    user = {
      codium.extraExtensions = with pkgs.open-vsx; [
        hashicorp.terraform
      ];

      firefox.extraPinnedItems = [
        "plugin_okta_com-browser-action"
      ];
    };
    programs.zsh.initContent =
      # sh
      ''
        complete -C "$(which aws_completer)" aws
        export AWS_PROFILE=amplify-learning-dev
        # Pyenv
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path && pyenv init - && pyenv virtualenv-init -)"
      '';
  };
}
