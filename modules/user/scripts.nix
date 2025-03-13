{
  pkgs,
  config,
  lib,
  homeDirectory,
  flakeDir,
  ...
}:
let
  scripts = [
    (lib.mkIf config.user.gui.enable (
      pkgs.writeShellScriptBin "get-resume" ''
        curl -L https://347online.me/resume.pdf -o "${homeDirectory}/Desktop/Katie Janzen Resumé 2025.pdf"
        curl -L https://347online.me/cover-letter.pdf -o "${homeDirectory}/Desktop/Katie Janzen Cover Letter 2025.pdf"
      ''
    ))
    (pkgs.writeShellScriptBin "newgit" ''
      mkdir $1 && (cd $1 && git init)
    '')

    (pkgs.writeShellScriptBin "secedit" ''
      cd ${flakeDir}
      if sops secrets.yaml; then
        git commit secrets.yaml -m "Secrets"
      fi
    '')

    (pkgs.writeShellScriptBin "eds" ''
      usage () {
        echo "Usage: eds [OPTIONS] [DIRECTORY]
        [OPTIONS]
          -s <session>  name of new tmux session
          -h            show this help message

        [DIRECTORY]
          Directory paths passed to editor - NYI
        "
      }

      session="$(basename $PWD)"

      while getopts ":s:h" opt; do
        case $opt in
          s)
            session=$OPTARG
            ;;
          h)
            usage
            exit 0
            ;;
          \?)
            echo "Bad option: -$OPTARG" >&2
            exit 1
            ;;
          :)
            echo "Option -$OPTARG requires value" >&2
            exit 1
            ;;
        esac
      done
      shift $((OPTIND - 1))

      if tmux has-session -t "$session" 2>/dev/null; then
        echo "Session" "$session" "already exists, attaching to it"
      else
        tmux new-session -d -s "$session"
        tmux rename-window -t 1 "editor"
        tmux new-window
        tmux rename-window -t 2 "scratch"
        tmux split-window -t "scratch" -v
        tmux resize-pane -Z
        # TODO: Use passed in directory
        if ! [[ $PWD == "${flakeDir}"* ]]; then
          tmux new-window
          tmux rename-window -t 3 "347OS"
          tmux send-keys -t "347OS" 'cd "${flakeDir}"' C-m 'clear' C-m
          tmux select-window -t "scratch"
        fi
        tmux select-window -t "editor"
        tmux send-keys -t "editor" "nvim $@" C-m
      fi

      tmux attach-session -t "$session"
    '')
  ];
in
{
  home.packages = scripts;
}
