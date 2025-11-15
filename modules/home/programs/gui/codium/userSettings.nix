{
  pkgs,
  ...
}:
{
  programs.vscode.profiles.default.userSettings = {
    "editor.acceptSuggestionOnCommitCharacter" = false;
    "editor.accessibilitySupport" = "off";
    "editor.autoClosingBrackets" = "never";
    "editor.autoClosingDelete" = "never";
    "editor.autoClosingOvertype" = "never";
    "editor.autoClosingQuotes" = "never";
    "editor.autoSurround" = "never";
    "editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";
    "editor.codeLens" = false;
    "editor.fontFamily" = "JetBrainsMono Nerd Font";
    "editor.fontLigatures" = true;
    "editor.formatOnSave" = true;
    "editor.inlayHints.enabled" = "offUnlessPressed";
    "editor.minimap.enabled" = false;
    "editor.mouseWheelScrollSensitivity" = 0.3;
    "editor.semanticHighlighting.enabled" = true;
    "editor.smoothScrolling" = true;
    "editor.tabSize" = 2;

    "eslint.codeAction.disableRuleComment"."enable" = false;
    # "eslint.format.enable" = true;

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
    "scm.showHistoryGraph" = false;

    "accessibility.signals.terminalBell".sound = "on";

    "terminal.external.linuxExec" = "wezterm";
    "terminal.external.osxExec" = "wezterm";
    "terminal.integrated.customGlyphs" = true;
    "terminal.integrated.defaultProfile.linux" = "zsh";
    "terminal.integrated.defaultProfile.osx" = "zsh";
    "terminal.integrated.enableVisualBell" = true;
    "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
    "terminal.integrated.mouseWheelScrollSensitivity" = 0.1;

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

    "prettier.documentSelectors" = [ "*.js" ];

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
    "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

    "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;

    "diffEditor.ignoreTrimWhitespace" = false;
    "livePreview.openPreviewTarget" = "External Browser";
    "liveServer.settings.donotShowInfoMsg" = true;
    "redhat.telemetry.enabled" = false;
    "search.useGlobalIgnoreFiles" = true;
    "database-client.autoSync" = false;

    "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[javascriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

    "[fish]"."editor.defaultFormatter" = "bmalehorn.vscode-fish";
    "[ignore]"."editor.defaultFormatter" = "foxundermoon.shell-format";
    "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
    "[shellscript]"."editor.defaultFormatter" = "foxundermoon.shell-format";
    "[toml]"."editor.defaultFormatter" = "tamasfe.even-better-toml";

    "[python]" = {
      "editor.wordBasedSuggestions" = "off";
      "editor.formatOnType" = true;
      "gitlens.codeLens.symbolScopes" = [ "!Module" ];
    };
  };
}
