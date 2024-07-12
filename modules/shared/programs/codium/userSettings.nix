{
  lib,
  pkgs,
  ...
}: {
  programs.vscode.userSettings = {
    "editor.acceptSuggestionOnCommitCharacter" = false;
    "editor.accessibilitySupport" = "off";
    "editor.autoClosingBrackets" = "never";
    "editor.autoClosingDelete" = "never";
    "editor.autoClosingOvertype" = "never";
    "editor.autoClosingQuotes" = "never";
    "editor.autoSurround" = "never";
    "editor.codeLens" = false;
    "editor.fontLigatures" = true;
    "editor.formatOnSave" = true;
    "editor.inlayHints.enabled" = "offUnlessPressed";
    "editor.minimap.enabled" = false;
    "editor.mouseWheelScrollSensitivity" = 0.3;
    "editor.semanticHighlighting.enabled" = true;
    "editor.smoothScrolling" = true;
    "editor.tabSize" = 2;

    "eslint.format.enable" = true;
    "eslint.codeAction.disableRuleComment" = {
      "enable" = false;
    };

    "explorer.sortOrder" = "type";

    "files.autoSave" = "afterDelay";
    "files.associations" = {
      "*.fish" = "fish";
      "{.env,.env.*}" = "properties";
    };

    "git.autofetch" = true;
    "git.confirmSync" = false;
    "git.openRepositoryInParentFolders" = "always";
    "gitlens.plusFeatures.enabled" = false;
    "gitlens.showWelcomeOnInstall" = false;
    "gitlens.showWhatsNewAfterUpgrades" = false;

    "terminal.external.osxExec" = "wezterm";
    "terminal.external.linuxExec" = "wezterm";
    "terminal.integrated.mouseWheelScrollSensitivity" = 0.1;
    "terminal.integrated.customGlyphs" = true;
    "terminal.integrated.defaultProfile.osx" = "zsh";
    "terminal.integrated.defaultProfile.linux" = "zsh";
    "terminal.integrated.enableVisualBell" = true;
    "accessibility.signals.terminalBell" = {
      sound = "on";
    };

    "update.showReleaseNotes" = false;

    "workbench.editor.empty.hint" = "hidden";
    "workbench.iconTheme" = "material-icon-theme";
    "workbench.list.mouseWheelScrollSensitivity" = 0.3;
    "workbench.startupEditor" = "none";
    "workbench.welcomePage.walkthroughs.openOnInstall" = false;
    "workbench.editorAssociations" = {
      "*.bin" = "hexEditor.hexedit";
    };

    "html.autoClosingTags" = false;
    "html.autoCreateQuotes" = false;

    "prettier.documentSelectors" = ["*.js"];

    "javascript.suggest.autoImports" = false;
    "javascript.autoClosingTags" = false;
    "typescript.suggest.autoImports" = false;
    "typescript.autoClosingTags" = false;

    "python.analysis.autoImportCompletions" = false;

    "rust-analyzer.check.command" = "clippy";
    "rust-analyzer.checkOnSave.command" = "clippy";
    "rust-analyzer.completion.callable.snippets" = "none";
    "rust-analyzer.hover.actions.implementations.enable" = false;
    "rust-analyzer.inlayHints.bindingModeHints.enable" = true;
    "rust-analyzer.showUnlinkedFileNotification" = false;

    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "${pkgs.nil}/bin/nil";

    "extensions.experimental.affinity" = {
      "asvetliakov.vscode-neovim" = 1;
    };

    "diffEditor.ignoreTrimWhitespace" = false;
    "livePreview.openPreviewTarget" = "External Browser";
    "liveServer.settings.donotShowInfoMsg" = true;
    "redhat.telemetry.enabled" = false;
    "search.useGlobalIgnoreFiles" = true;

    "sonarlint.focusOnNewCode" = true;
    "sonarlint.disableTelemetry" = true;
    "sonarlint.rules" = {
      "typescript:S6759" = {
        "level" = "off";
      };
      "typescript:S1854" = {
        "level" = "off";
      };
      "typescript:S6564" = {
        "level" = "off";
      };
      "typescript:S6606" = {
        "level" = "off";
      };
      "typescript:S1135" = {
        "level" = "off";
      };
      "typescript:S1186" = {
        "level" = "off";
      };
      "typescript:S6571" = {
        "level" = "off";
      };
      "typescript:S101" = {
        "level" = "off";
      };
      "typescript:S6509" = {
        "level" = "off";
      };
      "typescript:S4325" = {
        "level" = "off";
      };
    };

    "[json]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[jsonc]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[javascript]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[javascriptreact]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[typescript]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[typescriptreact]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[html]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[css]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
    "[rust]" = {
      "editor.defaultFormatter" = "rust-lang.rust-analyzer";
    };
    "[python]" = {
      "gitlens.codeLens.symbolScopes" = ["!Module"];
      "editor.wordBasedSuggestions" = "off";
      "editor.formatOnType" = true;
    };
    "[toml]" = {
      "editor.defaultFormatter" = "tamasfe.even-better-toml";
    };
    "[shellscript]" = {
      "editor.defaultFormatter" = "foxundermoon.shell-format";
    };
    "[fish]" = {
      "editor.defaultFormatter" = "bmalehorn.vscode-fish";
    };
    "[ignore]" = {
      "editor.defaultFormatter" = "foxundermoon.shell-format";
    };
  };
}
