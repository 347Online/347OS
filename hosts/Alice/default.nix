{
  username,
  pkgs,
  lib,
  vscode-extensions,
  ...
}:
{
  darwin.dock = {
    email.enable = false;
    apps = [
      "/Applications/Slack.app"
    ];
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
      "pipx"
      "pyenv"
      "pyenv-virtualenv"
    ];

    casks = [
      "docker"
    ];
  };

  home-manager.users.${username} = {
    accounts.email.accounts.Amplify = {
      thunderbird.enable = true;

      userName = "kjanzen@amplify.com";
      realName = "Katie Janzen";
      address = "kjanzen@amplify.com";
      primary = true;
      flavor = "gmail.com";
    };
    home.packages = with pkgs; [
      nodemon
      open-policy-agent
      serverless
      tflint
      tfupdate
      yarn
    ];
    user = {
      codium.extraExtensions = with vscode-extensions; [
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
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
      '';
  };
}
