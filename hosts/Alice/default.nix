{
  username,
  pkgs,
  lib,
  vscode-extensions,
  ...
}:
{
  darwin.dock = {
    browser = "Firefox";
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
      "nvm"
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
      serverless
      yarn
    ];
    user.codium.extraExtensions = with vscode-extensions; [
    ];
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
        export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
      '';
  };
}
