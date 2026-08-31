#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
PACKAGES=("gh" "rbenv" "ruby-build" "emacs" "zsh" "terraform" "docker" "go" "pyenv" "opam")
LINUX_PACKAGES=("xclip")

# Create symlinks for dotfiles
create_symlinks() {
    for file in $(find "$DOTFILES_DIR" -name '.*' | grep -v 'dotfiles/.git$' | perl -nle 'm!dotfiles/(.+)$! and print $1'); do
        local target="$HOME/$file"
        local source="$DOTFILES_DIR/$file"

        if [ ! -e "$target" ] && [ ! -L "$target" ]; then
            ln -s "$source" "$target"
        fi
    done

    # Remove .gitignore symlink (we don't want it in HOME)
    if [ -L "$HOME/.gitignore" ]; then
        rm "$HOME/.gitignore"
    fi
}

# Setup for macOS
setup_mac() {
    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install packages
    for package in "${PACKAGES[@]}"; do
        if ! brew list "$package" &> /dev/null; then
            brew install "$package"
        fi
    done

    # Install macOS specific package
    if ! brew list reattach-to-user-namespace &> /dev/null; then
        brew install reattach-to-user-namespace
    fi
}

# Setup for Linux (WSL/Ubuntu)
setup_linux() {
    sudo apt-get update
    sudo apt-get install -y "${PACKAGES[@]}" "${LINUX_PACKAGES[@]}"
}

# Install Spacemacs
install_spacemacs() {
    if [ ! -d "$HOME/.emacs.d" ]; then
        git clone git@github.com:bussorenre/spacemacs.git "$HOME/.emacs.d"
    fi
}

# Change default shell to zsh
change_shell_to_zsh() {
    local zsh_path=""

    if [ -f /bin/zsh ]; then
        zsh_path="/bin/zsh"
    elif [ -f /usr/bin/zsh ]; then
        zsh_path="/usr/bin/zsh"
    fi

    if [ -n "$zsh_path" ] && [ "$SHELL" != "$zsh_path" ]; then
        chsh -s "$zsh_path"
    fi
}

# Copy .local template files if they don't exist
create_local_templates() {
    local templates_dir="$DOTFILES_DIR/templates"

    for template in "$templates_dir"/*.example "$templates_dir"/.*.example; do
        [ -e "$template" ] || continue
        local filename
        filename=$(basename "${template%.example}")
        local target="$HOME/$filename"

        if [ ! -f "$target" ]; then
            cp "$template" "$target"
            echo "Created $target from template"
        fi
    done
}

# Main setup
main() {
    create_symlinks
    create_local_templates

    case $OSTYPE in
        darwin*)
            setup_mac
            ;;
        linux*)
            setup_linux
            ;;
        *)
            echo "Unsupported OS: $OSTYPE"
            exit 1
            ;;
    esac

    install_spacemacs
    change_shell_to_zsh
}

main
