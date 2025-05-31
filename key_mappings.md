# Key Mappings

**Leader Key**: `<Space>`

## Core Navigation & Editing

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `jk` (insert mode) | Core Neovim | Exit insert mode to normal mode |
| `<Space>nh` | Core Neovim | Clear search highlights |
| `x` | Core Neovim | Delete character without copying to register |
| `<Space>+` | Core Neovim | Increment number under cursor |
| `<Space>-` | Core Neovim | Decrement number under cursor |

## Window Management

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `<Space>st` | Core Neovim | Split window vertically |
| `<Space>sT` | Core Neovim | Split window horizontally |
| `<Space>se` | Core Neovim | Make split windows equal width & height |
| `<Space>sw` | Core Neovim | Close current split window |
| `<Space>sm` | vim-maximizer | Toggle split window maximization |

## Tab Management

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `<Space>tt` | Core Neovim | Open new tab |
| `<Space>tw` | Core Neovim | Close current tab |
| `<Space>tl` | Core Neovim | Go to next tab |
| `<Space>th` | Core Neovim | Go to previous tab |

## File Operations & Navigation

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `<Space>e` | nvim-tree | Toggle file explorer |
| `<Space>ff` | telescope.nvim | Find files in current working directory |
| `<Space>fs` | telescope.nvim | Live grep search in files |
| `<Space>fc` | telescope.nvim | Find string under cursor in current directory |
| `<Space>fb` | telescope.nvim | List open buffers |
| `<Space>fh` | telescope.nvim | List available help tags |

## Telescope Navigation (Insert Mode)

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `<C-k>` | telescope.nvim | Move to previous result in telescope |
| `<C-j>` | telescope.nvim | Move to next result in telescope |
| `<C-q>` | telescope.nvim | Send selected items to quickfix list |

## Autocompletion (Insert Mode)

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `<C-k>` | nvim-cmp | Select previous completion suggestion |
| `<C-j>` | nvim-cmp | Select next completion suggestion |
| `<C-b>` | nvim-cmp | Scroll completion documentation up |
| `<C-f>` | nvim-cmp | Scroll completion documentation down |
| `<C-Space>` | nvim-cmp | Show completion suggestions |
| `<C-e>` | nvim-cmp | Close completion window |
| `<CR>` | nvim-cmp | Confirm selected completion |

## LSP Navigation (Lspsaga)

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `<C-f>` | lspsaga.nvim | Scroll down in LSP preview window |
| `<C-b>` | lspsaga.nvim | Scroll up in LSP preview window |
| `<CR>` | lspsaga.nvim | Open file with definition preview |

## Comments

| Key Combination | Package/Source | Description |
|----------------|----------------|-------------|
| `gcc` (normal mode) | Comment.nvim | Toggle line comment |
| `gc` (visual mode) | Comment.nvim | Toggle comment for selection |
| `gbc` (normal mode) | Comment.nvim | Toggle block comment |
| `gb` (visual mode) | Comment.nvim | Toggle block comment for selection |