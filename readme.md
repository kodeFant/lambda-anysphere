# [Lambda Anysphere](https://marketplace.visualstudio.com/items?itemName=kodeFant.lambda-anysphere)

__Lambda Anysphere__ is a VS Code color theme optimised for Haskell with extra syntax colors for more language scopes. It's based on [Lambda Black](https://marketplace.visualstudio.com/items?itemName=janw4ld.lambda-black) and replaced with colors from [Anysphere Modern](https://marketplace.visualstudio.com/items?itemName=GustavoPrietodePaula.anysphere-modern).

## Color schemes
Black:
<p align="center">
  <img src="https://pomf2.lain.la/f/z6rumiaw.png" alt="Black color scheme" style="max-width:90%;">
</p>
Dark+:
<p align="center">
  <img src="https://pomf2.lain.la/f/cumylqsv.png" alt="Dark+ color scheme" style="max-width:90%;">
</p>

# Installation
You can get Lambda Anysphere on:

  - [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=kodeFant.lambda-anysphere)

Or install it from source:

1. Install dependencies:
    - [git](https://git-scm.com/downloads)
    - [nix](https://nixos.org/download/)
1. Clone the repo, build and install the extension:

    ```bash
    git clone --depth 1 git@github.com:kodeFant/lambda-anysphere.git && {
      cd lambda-anysphere
      
      nix-shell -- If you have only Nix installed  
      -- or nix develop - If you have flake enabled
      -- direnv allow -- If you have direnv installed and want automatic shell loading

      nix build

      code --install-extension result/lambda-anysphere.vsix
      # Alernatively Ctrl+Shift+P -> Shell Command: Install from VSIX...
    }
    ```
# Customisation
To change how something is highlighted, proceed as follows:

  - While browsing code containing highlighting you'd like to change, start the TextMate scope inspector as follows:
    - open the VS Code Command Palette (Ctrl+Shift+P),
    - start typing "Inspect Editor Tokens and Scopes" and select this item from the dropdown menu.
  - Click on the code whose highlighting you'd like to change; this will display the TextMate scopes associated to that piece of code. For instance, `if` in a Haskell source file is given the scope `keyword.control.if.haskell`.
  - Open your `settings.json` file:
    - open the VS Code Command Palette (Ctrl+Shift+P),
    - start typing "Open Settings (JSON)" and select this item from the dropdown menu.
  - Make the modifications by editing the value of `editor.tokenColorCustomizations` in your settings.
    For instance, to highlight `if` and `then` in red and `else` in blue, one would write:

```json
    "editor.tokenColorCustomizations": {
      "textMateRules": [
        {
          "scope": [ "keyword.control.if", "keyword.control.then" ],
          "settings": {
            "foreground": "#ff0000"
          }
        },
        {
          "scope": "keyword.control.else",
          "settings": {
            "foreground": "#0000ff"
          }
        }
      ]
    }
```
