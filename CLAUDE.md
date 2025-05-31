# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Neovim configuration using Lua. The structure follows a modular approach:

- `init.lua` - Entry point that requires all modules in order
- `lua/bruce/` - Main configuration namespace
  - `core/` - Core Neovim settings (options, keymaps, colorscheme)
  - `plugins-setup.lua` - Packer plugin manager configuration with all plugin declarations
  - `plugins/` - Individual plugin configurations, each in its own file

## Plugin Management

Uses Packer.nvim for plugin management. All plugins are declared in `lua/bruce/plugins-setup.lua` with their configurations in separate files under `lua/bruce/plugins/`.

Key plugins installed:
- LSP ecosystem: Mason, nvim-lspconfig, lspsaga
- File navigation: nvim-tree, telescope
- Completion: nvim-cmp with various sources
- Syntax highlighting: treesitter
- UI enhancements: lualine, catppuccin theme

## Key Leader Mappings

Leader key is set to space. Important keymaps defined in `lua/bruce/core/keymaps.lua`:
- `<leader>e` - Toggle file explorer (nvim-tree)
- `<leader>ff` - Find files (telescope)
- `<leader>fs` - Live grep search (telescope)
- `<leader>st/sT` - Split windows vertically/horizontally
- `<leader>tt` - New tab

## LSP Configuration

LSP setup is split across files in `lua/bruce/plugins/lsp/`:
- Mason auto-installs pylsp (Python LSP server)
- Lspconfig handles server configuration
- Lspsaga provides enhanced LSP UI

## Development Notes

- Uses 4-space indentation consistently
- Safe plugin loading with pcall() pattern throughout
- Modular structure allows easy addition/removal of plugin configurations
- Some commented code exists showing alternative configurations