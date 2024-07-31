# Katie's Nix Configuration

This is my setup for managing my computing life with Nix

## Features

- Modules for system configuration for both NixOS or macOS via nix-darwin
- Modules for portable userspace configuration via Home-Manager (WIP)
- Configurations for Work Laptop, Personal Laptop (both macOS and NixOS), and Home Server defined in hosts directory
- Portable Neovim setup

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
