# 347OS

This is my setup for managing my computing life with Nix

## Features

- Portable Neovim setup
- Modules for system configuration for both NixOS or macOS via nix-darwin
- Modules for portable userspace configuration via Home-Manager, including standalone
- Host Configurations:
  - Amber - Personal Workstation
  - Aspen - Home Server
  - Arukenia - Home Server Satellite Unit
  - Athena - Personal Laptop

## Usage

### Neovim

```bash
nix run "$FLAKE_DIR#nvim"
```

### Linux

```bash
# Selects the appropriate config by hostname
# Can optionally append #<HOSTNAME> to specify a specific host definition
sudo nixos-rebuild switch --flake "$FLAKE_DIR"
```

### Mac

```bash
# Selects the appropriate config by hostname
# Can optionally append #<HOSTNAME> to specify a specific host definition
darwin-rebuild switch --flake "$FLAKE_DIR"
```

### Generic Unix

```bash
# Portable Userspace for user 'katie'
home-manager switch --flake "$FLAKE_DIR"
```
