#!/bin/bash

# Neovim Configuration Installer
# Installs Neovim config with all dependencies across platforms
# Usage: curl -fsSL https://raw.githubusercontent.com/brucepucci/nvim/main/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/brucepucci/nvim.git"
CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Platform detection
detect_platform() {
    case "$(uname -s)" in
        Darwin*)
            PLATFORM="macos"
            ARCH="$(uname -m)"
            ;;
        Linux*)
            PLATFORM="linux"
            ARCH="$(uname -m)"
            # Detect distribution
            if [[ -f /etc/os-release ]]; then
                . /etc/os-release
                DISTRO="$ID"
            elif [[ -f /etc/redhat-release ]]; then
                DISTRO="rhel"
            elif [[ -f /etc/debian_version ]]; then
                DISTRO="debian"
            else
                DISTRO="unknown"
            fi
            ;;
        *)
            log_error "Unsupported platform: $(uname -s)"
            exit 1
            ;;
    esac
    
    log_info "Detected platform: $PLATFORM ($ARCH)"
    [[ "$PLATFORM" == "linux" ]] && log_info "Detected distribution: $DISTRO"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies for macOS
install_macos_deps() {
    log_info "Installing dependencies for macOS..."
    
    # Install Homebrew if not present
    if ! command_exists brew; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ "$ARCH" == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
    
    # Install required packages
    brew update
    brew install neovim git ripgrep node python3
    
    # Install a Nerd Font
    brew tap homebrew/cask-fonts
    brew install font-hack-nerd-font || log_warning "Font installation failed - install manually from nerdfonts.com"
}

# Install dependencies for Linux
install_linux_deps() {
    log_info "Installing dependencies for Linux ($DISTRO)..."
    
    case "$DISTRO" in
        ubuntu|debian)
            sudo apt update
            sudo apt install -y curl git build-essential
            
            # Install Neovim (try AppImage for latest version)
            if ! command_exists nvim || [[ "$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)" < "0.8" ]]; then
                log_info "Installing latest Neovim..."
                curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
                chmod u+x nvim.appimage
                sudo mv nvim.appimage /usr/local/bin/nvim
            fi
            
            # Install other dependencies
            sudo apt install -y ripgrep nodejs npm python3 python3-pip
            ;;
            
        arch|manjaro)
            sudo pacman -Sy --noconfirm neovim git ripgrep nodejs npm python python-pip base-devel
            ;;
            
        fedora|rhel|centos)
            if command_exists dnf; then
                sudo dnf install -y neovim git ripgrep nodejs npm python3 python3-pip
            elif command_exists yum; then
                sudo yum install -y neovim git nodejs npm python3 python3-pip
                # Install ripgrep manually for older systems
                if ! command_exists rg; then
                    log_info "Installing ripgrep manually..."
                    curl -LO https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
                    tar xzf ripgrep-*.tar.gz
                    sudo cp ripgrep-*/rg /usr/local/bin/
                    rm -rf ripgrep-*
                fi
            fi
            ;;
            
        alpine)
            sudo apk add --no-cache neovim git ripgrep nodejs npm python3 py3-pip build-base
            ;;
            
        *)
            log_warning "Unknown distribution: $DISTRO"
            log_info "Please install manually: neovim (0.8+), git, ripgrep, nodejs, python3"
            read -p "Continue anyway? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
            ;;
    esac
}

# Verify installations
verify_dependencies() {
    log_info "Verifying dependencies..."
    
    local missing_deps=()
    
    # Check required commands
    if ! command_exists nvim; then
        missing_deps+=("neovim")
    else
        local nvim_version=$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
        if [[ "$(printf '%s\n' "0.8" "$nvim_version" | sort -V | head -n1)" != "0.8" ]]; then
            log_warning "Neovim version $nvim_version detected. Version 0.8+ recommended."
        fi
    fi
    
    if ! command_exists git; then missing_deps+=("git"); fi
    if ! command_exists rg; then missing_deps+=("ripgrep"); fi
    if ! command_exists node; then missing_deps+=("nodejs"); fi
    if ! command_exists python3; then missing_deps+=("python3"); fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        log_error "Please install them manually and run this script again."
        exit 1
    fi
    
    log_success "All dependencies verified!"
}

# Backup existing config
backup_existing_config() {
    if [[ -d "$CONFIG_DIR" ]]; then
        log_warning "Existing Neovim config found at $CONFIG_DIR"
        log_info "Creating backup at $BACKUP_DIR"
        mv "$CONFIG_DIR" "$BACKUP_DIR"
        log_success "Backup created at $BACKUP_DIR"
    fi
}

# Clone and setup configuration
setup_config() {
    log_info "Cloning Neovim configuration..."
    
    # Create config directory
    mkdir -p "$(dirname "$CONFIG_DIR")"
    
    # Clone repository
    git clone "$REPO_URL" "$CONFIG_DIR"
    cd "$CONFIG_DIR"
    
    log_success "Configuration cloned successfully!"
}

# Install plugins and LSP servers
install_plugins() {
    log_info "Installing Neovim plugins..."
    
    # Install Packer and sync plugins
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    
    log_info "Installing LSP servers..."
    
    # Install LSP servers via Mason
    nvim --headless -c 'MasonInstall pylsp' -c 'quitall'
    
    log_success "Plugins and LSP servers installed!"
}

# Post-installation setup
post_install() {
    log_info "Running post-installation setup..."
    
    # Update treesitter parsers
    nvim --headless -c 'TSUpdateSync' -c 'quitall'
    
    log_success "Post-installation setup complete!"
}

# Display success message
show_success_message() {
    echo
    log_success "🎉 Neovim configuration installed successfully!"
    echo
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Restart your terminal or run: source ~/.bashrc (or ~/.zshrc)"
    echo "2. Run: nvim"
    echo "3. Everything should work out of the box!"
    echo
    echo -e "${BLUE}Key bindings:${NC}"
    echo "• <Space>. - Toggle file explorer"
    echo "• <Space>ff - Find files"
    echo "• <Space>fs - Live grep search"
    echo "• <Space>mp - Markdown preview"
    echo "• <Space>\` - Toggle Python REPL"
    echo
    echo -e "${BLUE}Troubleshooting:${NC}"
    echo "• Run :checkhealth in Neovim to verify setup"
    echo "• Check README.md in ~/.config/nvim for more info"
    echo "• If you have issues, your backup is at: $BACKUP_DIR"
    echo
}

# Main installation function
main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════╗"
    echo "║     Neovim Configuration Installer   ║"
    echo "║                                      ║"
    echo "║  This will install a complete        ║"
    echo "║  Neovim setup with LSP, plugins,     ║"
    echo "║  and all dependencies.               ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${NC}"
    echo
    
    # Confirm installation
    read -p "Continue with installation? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled."
        exit 0
    fi
    
    # Run installation steps
    detect_platform
    
    case "$PLATFORM" in
        macos)
            install_macos_deps
            ;;
        linux)
            install_linux_deps
            ;;
    esac
    
    verify_dependencies
    backup_existing_config
    setup_config
    install_plugins
    post_install
    show_success_message
}

# Error handling
trap 'log_error "Installation failed at line $LINENO"' ERR

# Run main function
main "$@"