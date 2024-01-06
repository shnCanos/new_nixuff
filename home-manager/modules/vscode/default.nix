{ config, lib, pkgs, ... }:

let
  myKeybinds = [
    # Mine
    {
      key = "space";
      command = "vspacecode.space";
      when = "editorTextFocus && neovim.mode != insert";
    }
    {
      key = "shift+escape";
      command = "vscode-neovim.escape";
      # when = "neovim.mode == insert"; # I am not gonna use it outside insert mode so might as well
    }
    {
      key = "alt+x";
      command = "workbench.action.showCommands";
    }
    {
      key = "ctrl+shift+k";
      command = "workbench.action.terminal.toggleTerminal";
    }
  ];

  defaultVSpaceCodeKeybinds = [
    # Default
    {
      key = "space";
      command = "vspacecode.space";
      when =
        "activeEditorGroupEmpty && focusedView == '' && !whichkeyActive && !inputFocus";
    }
    {
      key = "space";
      command = "vspacecode.space";
      when = "sideBarFocus && !inputFocus && !whichkeyActive";
    }
    {
      key = "ctrl+j";
      command = "workbench.action.quickOpenSelectNext";
      when = "inQuickOpen";
    }
    {
      key = "ctrl+k";
      command = "workbench.action.quickOpenSelectPrevious";
      when = "inQuickOpen";
    }
    {
      key = "ctrl+j";
      command = "selectNextSuggestion";
      when =
        "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      key = "ctrl+k";
      command = "selectPrevSuggestion";
      when =
        "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      key = "ctrl+l";
      command = "acceptSelectedSuggestion";
      when =
        "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
    }
    {
      key = "ctrl+j";
      command = "showNextParameterHint";
      when =
        "editorFocus && parameterHintsMultipleSignatures && parameterHintsVisible";
    }
    {
      key = "ctrl+k";
      command = "showPrevParameterHint";
      when =
        "editorFocus && parameterHintsMultipleSignatures && parameterHintsVisible";
    }
    {
      key = "ctrl+j";
      command = "selectNextCodeAction";
      when = "codeActionMenuVisible";
    }
    {
      key = "ctrl+k";
      command = "selectPrevCodeAction";
      when = "codeActionMenuVisible";
    }
    {
      key = "ctrl+l";
      command = "acceptSelectedCodeAction";
      when = "codeActionMenuVisible";
    }
    {
      key = "ctrl+h";
      command = "file-browser.stepOut";
      when = "inFileBrowser";
    }
    {
      key = "ctrl+l";
      command = "file-browser.stepIn";
      when = "inFileBrowser";
    }
  ];

in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions;
      [
        # Language support
        rust-lang.rust-analyzer
        # ms-pyright.pyright
        ms-python.python
        dart-code.flutter
        ms-vsliveshare.vsliveshare
        # TODO: nash.awesome-flutter-snippets
        # TODO: alexisvt.flutter-snippets

        # bbenoist.nix
        jnoortheen.nix-ide

        # SpaceCode
        vspacecode.vspacecode
        vspacecode.whichkey
        bodil.file-browser
        kahole.magit
        asvetliakov.vscode-neovim
        # ms-toolsai.jupyter

        # Other
        foam.foam-vscode
        yzhang.markdown-all-in-one
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "pastel-theme";
          publisher = "cval";
          version = "1.4.1";
          sha256 = "5YUpm9RyyP/Xwz+sb4GjDTGi8ogiLorwOnp80ih1L7g=";
        }
        {
          name = "prologtester";
          publisher = "SkyDev";
          version = "0.5.1";
          sha256 = "Xp4lXz+XV1cm4uld4srhvVyWdND67zMbmYBx9uuQb7w=";
        }
      ];

    keybindings = myKeybinds ++ defaultVSpaceCodeKeybinds;

    userSettings = {
      # Default
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.lineNumbers" = "relative";
      "keyboard.dispatch" = "keyCode";
      "workbench.colorTheme" = "Pastel";
      "editor.fontLigatures" = "true";
      "editor.fontFamily" = "'Fira Code'";
      "terminal.integrated.fontFamily" = "'Fira Code'";
      "editor.fontSize" = 15;
      "editor.minimap.enabled" = false;
      "telemetry.telemetryLevel" = "off";
      "terminal.external.linuxExec" = "kitty"; # Why does this not work?
      "terminal.explorerKind" = "integrated";
      "workbench.startupEditor" = "none";
      "dart.flutterSdkPath" = pkgs.flutter-unwrapped.outPath;
      # "dart.sdkPaths" = [ pkgs.flutter.outPath pkgs.dart.outPath ];
      # "dart.flutterSdkPath" = "${homePath}/Projects/github/flutter";
      # "dart.flutterSdkPath" = (pkgs.callPackage ../deriv/flutter.nix { }).outPath;

      # ZenMode
      "zenMode.hideLineNumbers" = false;
      "zenMode.hideStatusBar" = true;

      # Vscode Neovim
      "vscode-neovim.neovimInitVimPaths.linux" = ./init.vim;
      "extensions.experimental.affinity"."asvetliakov.vscode-neovim" = 1;

      # Nix-IDE
      "nix.enableLanguageServer" = true;

      # Foam
      "foam.openDailyNote.directory" = "daily";

      # VSpaceCode
      "vspacecode.bindingOverrides" = [
        {
          "keys" = "b.s";
          "name" = "Save File";
          "type" = "command";
          "command" = "workbench.action.files.save";
        }
        {
          "keys" = "t.z";
          "name" = "Toggle zen mode";
          "type" = "command";
          "command" = "workbench.action.toggleZenMode";
        }
        {
          "keys" = "w.q";
          "name" = "Quit window";
          "type" = "command";
          "command" = "workbench.action.closeEditorsAndGroup";
        }
        {
          "keys" = "b.k";
          "name" = "Kill Buffer";
          "type" = "command";
          "command" = "workbench.action.closeActiveEditor";
        }
        # {
        #   "keys" = ",";
        #   "name" = "Search Buffers";
        #   "type" = "command";
        #   "command" = "";
        # }
      ];
    };
  };

}
