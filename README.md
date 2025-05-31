# Neovim Configuration

A modular Neovim configuration built with Lua, featuring LSP support, file navigation, autocompletion, and modern UI enhancements.

## Prerequisites

- **Neovim 0.8+** (install with `brew install neovim`)
- **Git** (for cloning plugins)
- **A Nerd Font** (optional but recommended for icons)
- **ripgrep** (for telescope live grep): `brew install ripgrep`
- **Node.js** (for some LSP servers): `brew install node`

## Installation

### 1. Clone or Copy Configuration

If you're setting this up fresh, copy all files to your Neovim config directory:

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Create config directory
mkdir -p ~/.config/nvim

# Copy this configuration to ~/.config/nvim
```

### 2. First Launch Setup

1. **Start Neovim**:
   ```bash
   nvim
   ```

2. **Install Packer** (automatic):
   - The configuration automatically installs Packer on first run
   - You'll see Packer cloning itself to the data directory

3. **Install Plugins**:
   ```bash
   :PackerSync
   ```
   - This downloads and installs all plugins
   - Wait for completion (green checkmarks)
   - Restart Neovim: `:qa` then `nvim`

4. **Install LSP Servers**:
   ```bash
   :Mason
   ```
   - Mason will auto-install pylsp (Python LSP server)
   - You can install additional servers here if needed

### 3. Verify Installation

#### Check for Errors
```bash
# Check health of Neovim installation
:checkhealth

# Check specific components
:checkhealth telescope
:checkhealth nvim-treesitter
:checkhealth lsp
```

#### Test Key Features

1. **File Explorer**: Press `<Space>e` to toggle nvim-tree
2. **File Search**: Press `<Space>ff` to open Telescope file finder
3. **Live Grep**: Press `<Space>fs` to search in files
4. **LSP**: Open a Python file - you should see:
   - Syntax highlighting
   - Error diagnostics
   - Autocompletion with `<Tab>`

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

**Leader Key**: `<Space>`

### File Operations
- `<Space>e` - Toggle file explorer
- `<Space>ff` - Find files
- `<Space>fs` - Live grep search
- `<Space>fc` - Find word under cursor
- `<Space>fb` - List open buffers

### Window Management
- `<Space>st` - Split vertically
- `<Space>sT` - Split horizontally
- `<Space>se` - Equalize splits
- `<Space>sw` - Close split

### Tabs
- `<Space>tt` - New tab
- `<Space>tw` - Close tab
- `<Space>tl` - Next tab
- `<Space>th` - Previous tab

### Other
- `jk` (in insert mode) - Exit to normal mode
- `<Space>nh` - Clear search highlights

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