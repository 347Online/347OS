# Katie's Nix Configuration

This is my setup for managing my computing life with Nix

## Features

- Modules for system configuration for both NixOS or macOS via nix-darwin
- Modules for portable userspace configuration via Home-Manager
- Work and Personal Configurations defined in the hosts directory
- Portable Neovim setup

## Usage

### Mac

```bash
# Selects the appropriate config by hostname
# Can optionally append #<HOSTNAME> to specify a specific host definition
darwin-rebuild switch --flake <FLAKE_DIR>
```

### Neovim

```bash
nix run <FLAKE_DIR>#nvim
```

## Troubleshooting

### `domain does not exist`

This is usually a problem with the Mail preferences

Navigate to `/Users/katie/Library/Containers/` in the Finder

Move all directories labelled as "Mail" to the Desktop

Now put the directories back in there previous location (e.g. with Cmd + Z) and try again
