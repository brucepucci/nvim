# Neovim Configuration

A modular Neovim configuration built with Lua, featuring LSP support, file navigation, autocompletion, and modern UI enhancements.

## Prerequisites

- **Neovim 0.8+** (install with `brew install neovim`)
- **Git** (for cloning plugins)
- **A Nerd Font** (optional but recommended for icons)
- **ripgrep** (required for telescope search): `brew install ripgrep`
- **Node.js** (for LSP servers and markdown preview): `brew install node`

## Installation

### Quick Install (Recommended)

**One-line install script that handles everything:**

```bash
curl -fsSL https://raw.githubusercontent.com/brucepucci/nvim/main/install.sh | bash
```

This script will:
- ✅ Detect your platform (macOS/Linux/ARM)
- ✅ Install all dependencies automatically
- ✅ Backup any existing config
- ✅ Clone and setup this configuration
- ✅ Install all plugins and LSP servers
- ✅ Verify everything works

**Supported platforms:**
- macOS (Intel & Apple Silicon)
- Ubuntu/Debian
- Arch Linux
- Fedora/RHEL/CentOS
- Alpine Linux
- Raspberry Pi (ARM)

### Manual Installation

If you prefer manual setup:

#### 1. Install Dependencies

**macOS:**
```bash
brew install neovim git ripgrep node python3
brew install font-hack-nerd-font
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install neovim git ripgrep nodejs npm python3 python3-pip
```

**Arch Linux:**
```bash
sudo pacman -S neovim git ripgrep nodejs npm python python-pip
```

#### 2. Clone Configuration

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone https://github.com/brucepucci/nvim.git ~/.config/nvim
```

#### 3. Install Plugins & LSP

```bash
# Install plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Install LSP servers
nvim --headless -c 'MasonInstall pylsp' -c 'quitall'
```

### 3. Verify Installation

#### Check for Errors
```bash
# Check health of Neovim installation
:checkhealth

# Check specific components
:checkhealth telescope
:checkhealth nvim-treesitter
:checkhealth vim.lsp
```

**Note**: You may see a deprecation warning about `:checkhealth lspconfig` - this is normal and doesn't affect functionality.

#### Quick Prerequisites Check
```bash
# Verify all required tools are installed
nvim --version && rg --version && node --version
```
All commands should return version information without errors.

#### Test Key Features

1. **File Explorer**: Press `<Space>.` to toggle nvim-tree
2. **File Search**: Press `<Space>ff` to open Telescope file finder
3. **Live Grep**: Press `<Space>fs` to search in files
4. **Markdown**: Open a `.md` file to see:
   - Beautiful in-buffer rendering
   - Press `<Space>mp` for browser preview
5. **LSP**: Open a Python file - you should see:
   - Syntax highlighting
   - Error diagnostics
   - Autocompletion with `<Tab>`
6. **Python REPL**: Press `<Space>`` to toggle iPython REPL

#### Common Issues and Solutions

**Packer not found**:
```bash
# Manually install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

**Telescope fzf errors**:
```bash
# Ensure telescope-fzf-native compiles
:PackerCompile
```

**Missing icons**:
- Install a Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/)
- Set your terminal to use the Nerd Font

**LSP not working**:
```bash
# Check LSP status
:LspInfo

# Reinstall language servers
:Mason
# Then reinstall pylsp or other servers
```

## Key Mappings

See [key_mappings.md](key_mappings.md) for a comprehensive list of all key mappings organized by function.

## Plugin Management

### Adding New Plugins
1. Edit `lua/bruce/plugins-setup.lua`
2. Add plugin with `use('author/plugin-name')`
3. Run `:PackerSync`
4. Create config file in `lua/bruce/plugins/` if needed
5. Require the config in `init.lua`

### Updating Plugins
```bash
:PackerUpdate
```

### Cleaning Unused Plugins
```bash
:PackerClean
```

## Troubleshooting

If you encounter issues:

1. **Check Neovim version**: `nvim --version` (should be 0.8+)
2. **Run health checks**: `:checkhealth`
3. **Clear plugin cache**: Delete `~/.local/share/nvim` and reinstall
4. **Check error messages**: `:messages`
5. **Verify file permissions**: Ensure config files are readable

## Customization

The configuration is modular. Key files to modify:

- `lua/bruce/core/options.lua` - Editor settings
- `lua/bruce/core/keymaps.lua` - Key mappings
- `lua/bruce/core/colorscheme.lua` - Theme settings
- `lua/bruce/plugins-setup.lua` - Plugin list
- Individual plugin configs in `lua/bruce/plugins/`