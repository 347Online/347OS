# Katie's Nix Configuration

This is my setup for managing my computing life with Nix

## Features

- Portable Neovim setup
- Modules for system configuration for both NixOS or macOS via nix-darwin
- Modules for portable userspace configuration via Home-Manager
- Host Configurations:
  - Alice - Work Laptop
  - Athena - Personal Laptop
  - Aspen - Primary Home Server
  - Astrid - Home Server Satellite Unit

## Usage

### Mac

```bash
# Selects the appropriate config by hostname
# Can optionally append #<HOSTNAME> to specify a specific host definition
darwin-rebuild switch --flake <FLAKE_DIR>
```

### Linux

```bash
# Selects the appropriate config by hostname
# Can optionally append #<HOSTNAME> to specify a specific host definition
sudo nixos-rebuild switch --flake <FLAKE_DIR>
```

### Neovim

```bash
nix run <FLAKE_DIR>#nvim
```
