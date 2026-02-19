# dotfiles

My cross-platform config — macOS (primary) and Linux (Hyprland).

## Setup

Clone into `~/.config` and run the symlink script:

```bash
git clone <your-repo-url> ~/.config
~/.config/scripts/symlink.sh
```

This creates the following symlinks in `$HOME`:

| Symlink | Target |
|---------|--------|
| `~/.zshrc` | `~/.config/zshrc` |
| `~/.tmux.conf` | `~/.config/tmux/tmux.conf` |
| `~/.skhdrc` | `~/.config/skhdrc` |
| `~/.yabairc` | `~/.config/yabairc` |
| `~/.ideavimrc` | `~/.config/ideavimrc` |

If a file already exists at the target, it's backed up to `<file>.bak`.
Existing symlinks are skipped.

## Install (Homebrew)

### Formulae

```bash
# Shells & prompt
brew install zsh fish nushell zsh-syntax-highlighting starship

# Editors
brew install neovim helix emacs
brew tap d12frosted/emacs-plus && brew install emacs-plus@31

# Multiplexers
brew install tmux zellij tpm

# macOS window management & bar
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install FelixKratz/formulae/sketchybar

# File managers & navigation
brew install ranger yazi eza fd fzf tree zoxide

# Search & text
brew install bat grep gnu-sed gnu-tar jq ripgrep

# Git
brew install gh gitui lazygit mercurial

# System monitoring
brew install btop htop asitop macmon mactop fastfetch neofetch

# Dev — Go
brew install go gopls golangci-lint-langserver

# Dev — Rust
brew install rustup rust-analyzer cargo-release

# Dev — Java/Kotlin
brew install jdtls kotlin-language-server ktlint

# Dev — Mobile
brew install cocoapods scrcpy
brew install leoafarias/fvm/fvm

# Dev — build tools
brew install cmake make automake bison clang-format lld protobuf just

# Dev — containers
brew install docker docker-compose dockerfile-language-server lima

# Dev — Ruby
brew install chruby rbenv ruby-install ruby@3.3

# Dev — Python
brew install pipenv pipx uv

# Dev — misc
brew install hugo shfmt shellcheck

# Networking
brew install cloudflared telnet netcat wget
brew install showwin/speedtest/speedtest

# CLI utilities
brew install coreutils awk bc rename sevenzip watch
brew install direnv exiftool loc pandoc thefuck tlrc
brew install sesh zoxide ollama mpv transmission-cli
brew install handbrake cpdf pillow vips wordnet
```

### Casks

```bash
# Terminals
brew install --cask ghostty alacritty

# Browsers
brew install --cask chromium zen

# Editors & dev
brew install --cask cursor android-studio dbeaver-community codex

# Productivity
brew install --cask 1password slack whatsapp zoom

# Utilities
brew install --cask appcleaner caffeine keka keycastr localsend
brew install --cask maccy oversight stats anybar

# Keyboard & mouse
brew install --cask karabiner-elements linearmouse

# Media
brew install --cask obs vlc qbittorrent

# Networking & API
brew install --cask openvpn-connect bruno

# Science & typesetting
brew install --cask anaconda mactex xquartz

# AI
brew install --cask ollama-app

# Other
brew install --cask amical android-platform-tools

# Fonts (all Nerd Fonts + extras)
brew install --cask font-caskaydia-cove-nerd-font \
  font-jetbrains-mono-nerd-font \
  font-fira-code-nerd-font \
  font-hack-nerd-font \
  font-meslo-lg-nerd-font \
  font-monaspace \
  font-cascadia-code \
  font-symbols-only-nerd-font
# ... and many more nerd font variants
```

### Not on Homebrew

| Tool | Install |
|------|---------|
| [Doom Emacs](https://github.com/doomemacs/doomemacs) | `git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs && ~/.config/emacs/bin/doom install` |
| [TPM (tmux)](https://github.com/tmux-plugins/tpm) | `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` |
| [Fisher (fish)](https://github.com/jorgebucaran/fisher) | `curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \| source && fisher install jorgebucaran/fisher` |
| [LazyVim](https://github.com/LazyVim/LazyVim) | Bootstrapped via `nvim/lua/config/lazy.lua` — just open `nvim` |
| [Rofi](https://github.com/davatorium/rofi) | Linux only — `pacman -S rofi` / `apt install rofi` |
| [Hyprland](https://github.com/hyprwm/Hyprland) | Linux only — see [wiki](https://wiki.hyprland.org/Getting-Started/Installation/) |
| [Waybar](https://github.com/Alexays/Waybar) | Linux only — `pacman -S waybar` / `apt install waybar` |
| [Polybar](https://github.com/polybar/polybar) | Linux only — `pacman -S polybar` |
| [Wofi](https://hg.sr.ht/~scoopta/wofi) | Linux only — `pacman -S wofi` |
| [i3](https://github.com/i3/i3) | Linux only — `pacman -S i3-wm` |
| [warpd](https://github.com/rvaiya/warpd) | Build from source — see [repo](https://github.com/rvaiya/warpd) |

---

## macOS apps (cask)

| App | What it does |
|-----|-------------|
| [1Password](https://1password.com/) | Password manager |
| [Stats](https://github.com/exelban/stats) | Menu bar system monitor (CPU, memory, disk, network, battery) |
| [Maccy](https://maccy.app/) | Lightweight clipboard manager |
| [Caffeine](https://intelliscapesolutions.com/apps/caffeine) | Prevents Mac from sleeping |
| [AppCleaner](https://freemacsoft.net/appcleaner/) | Thorough app uninstaller |
| [Keka](https://www.keka.io/) | File archiver (zip, 7z, tar, etc.) |
| [KeyCastr](https://github.com/keycastr/keycastr) | Displays keystrokes on screen |
| [OverSight](https://objective-see.org/products/oversight.html) | Alerts when mic/camera are accessed |
| [LocalSend](https://localsend.org/) | AirDrop alternative (cross-platform) |
| [AnyBar](https://github.com/tonsky/AnyBar) | Menu bar status indicator dot |
| [LinearMouse](https://linearmouse.app/) | Per-device mouse/trackpad tuning |
| [Karabiner-Elements](https://karabiner-elements.pqrs.org/) | Keyboard remapping (home-row mods) |
| [Ghostty](https://ghostty.org/) | GPU terminal emulator |
| [Alacritty](https://alacritty.org/) | GPU terminal emulator |
| [Cursor](https://cursor.com/) | AI code editor |
| [Android Studio](https://developer.android.com/studio) | Android IDE |
| [DBeaver](https://dbeaver.io/) | Database GUI |
| [Bruno](https://www.usebruno.com/) | API client (Postman alternative) |
| [OBS](https://obsproject.com/) | Screen recording & streaming |
| [VLC](https://www.videolan.org/vlc/) | Media player |
| [qBittorrent](https://www.qbittorrent.org/) | Torrent client |
| [Ollama](https://ollama.com/) | Local LLM runner |
| [Zen](https://zen-browser.app/) | Privacy-focused browser |
| [Chromium](https://www.chromium.org/) | Open-source browser |
| [Slack](https://slack.com/) | Team messaging |
| [WhatsApp](https://www.whatsapp.com/) | Messaging |
| [Zoom](https://zoom.us/) | Video calls |
| [OpenVPN Connect](https://openvpn.net/client/) | VPN client |
| [Anaconda](https://www.anaconda.com/) | Python/data science distribution |
| [MacTeX](https://tug.org/mactex/) | LaTeX distribution |

---

## What's in here

### Shells

| Config | Tool | What it does |
|--------|------|-------------|
| [`.zshrc`](.zshrc) | [Zsh](https://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/) | Primary shell. Plugins: git, autosuggestions, fast-syntax-highlighting, fzf-tab. Uses eza/bat/fd/zoxide. |
| [`zshrc`](zshrc) | Zsh (alt) | Simpler variant with vi mode and natural text editing. |
| [`starship.toml`](starship.toml) | [Starship](https://starship.rs/) | Cross-shell prompt. Gruvbox Dark palette, language versions, git status, vim mode indicators. |

### Terminal emulators

| Config | Tool | What it does |
|--------|------|-------------|
| [`ghostty/`](ghostty/) | [Ghostty](https://ghostty.org/) | Primary terminal. Catppuccin Mocha, CaskaydiaCove NF size 21, blur, hidden titlebar. Super+1-9 for tmux windows. |
| [`alacritty/`](alacritty/) | [Alacritty](https://alacritty.org/) | GPU terminal. Catppuccin Mocha, CaskaydiaCove NF size 15, slight transparency. Defaults to Fish. |

### Multiplexers

| Config | Tool | What it does |
|--------|------|-------------|
| [`tmux/`](tmux/) | [tmux](https://github.com/tmux-plugins/tpm) | Prefix: `C-Space`. Catppuccin Mocha theme. Vi copy mode, vim-tmux-navigator, which-key, sesh session picker (`prefix+T`). OSC 52 clipboard. |

### Editors

| Config | Tool | What it does |
|--------|------|-------------|
| [`nvim/`](nvim/) | [Neovim](https://neovim.io/) + [LazyVim](https://www.lazyvim.org/) | Primary editor. LSP for Go, Rust, C, Java, Kotlin, Flutter/Dart. Plugins: oil, neogit, flash, snacks. Catppuccin theme. |
| [`doom/`](doom/) | [Doom Emacs](https://github.com/doomemacs/doomemacs) | Emacs distro. Corfu completion, vertico, treemacs+LSP, ligatures, emoji. |
| [`ideavimrc`](ideavimrc) | [IdeaVim](https://github.com/JetBrains/ideavim) | Vim layer for JetBrains. Leader=Space. EasyMotion, surround, commentary, multiple cursors. Flutter extract widget on `<leader>W`. |

### macOS window management

| Config | Tool | What it does |
|--------|------|-------------|
| [`yabairc`](yabairc) | [Yabai](https://github.com/koekeishiya/yabai) | Tiling WM. BSP layout, 6px gaps/padding. fn+mouse to move/resize. |
| [`skhdrc`](skhdrc) | [skhd](https://github.com/koekeishiya/skhd) | Hotkey daemon. `Cmd+Return`=Ghostty, `Alt+hjkl`=focus, `Alt+1-9`=spaces, `Ctrl+N`=perpetual note on space 6. |
| [`yabai/toggle_padding`](yabai/toggle_padding) | Script | Toggles yabai padding between default 6px and a given value. Supports percentages. |

### Keyboard & mouse

| Config | Tool | What it does |
|--------|------|-------------|
| [`karabiner/`](karabiner/) | [Karabiner-Elements](https://karabiner-elements.pqrs.org/) | Keyboard remapping. Home-row mods (ASDF = modifiers). |
| [`linearmouse/`](linearmouse/) | [LinearMouse](https://linearmouse.app/) | Per-device mouse config. Reverse scroll on Logitech MX Master 3S. |

### Linux (Hyprland)

| Config | Tool | What it does |
|--------|------|-------------|
| [`hypr/`](hypr/) | [Hyprland](https://hyprland.org/) | Wayland compositor. Omarchy layout, keybinds, autostart, window rules, hypridle, hyprlock. |
| [`waybar/`](waybar/) | [Waybar](https://github.com/Alexays/Waybar) | Status bar. Catppuccin Mocha. Modules: workspaces, clock, battery, bluetooth, network, spotify, tray. |
| [`rofi/`](rofi/) | [Rofi](https://github.com/davatorium/rofi) | App launcher. Multiple styles, clipboard mode, steam game launcher, wallbash integration. |
| [`polybar/`](polybar/) | [Polybar](https://github.com/polybar/polybar) | Alt status bar for i3. |
| [`i3/`](i3/) | [i3](https://i3wm.org/) | Alt tiling WM (X11). |
| [`wofi/`](wofi/) | [Wofi](https://hg.sr.ht/~scoopta/wofi) | Alt Wayland launcher. |

### CLI tools

| Config | Tool | What it does |
|--------|------|-------------|
| [`btop/`](btop/) | [btop](https://github.com/aristocratos/btop) | System monitor. |
| [`fastfetch/`](fastfetch/) | [Fastfetch](https://github.com/fastfetch-cli/fastfetch) | System info fetch. Custom config with Arch/Hyde logos. |
| [`neofetch/`](neofetch/) | [Neofetch](https://github.com/dylanaraps/neofetch) | System info fetch (legacy). |
| [`macmon.json`](macmon.json) | [macmon](https://github.com/vladkens/macmon) | Apple Silicon monitor. Sparkline view, green, 1s interval. |
| [`gh/`](gh/) | [GitHub CLI](https://cli.github.com/) | GitHub auth and config. |
| [`thefuck/`](thefuck/) | [thefuck](https://github.com/nvbn/thefuck) | Corrects previous console command. |

### Scripts

| Script | What it does |
|--------|-------------|
| [`scripts/perpetual-note.sh`](scripts/perpetual-note.sh) | Opens `~/notes/perpetual.md` in Neovim, auto-prepends today's date header. Bound to `Ctrl+N` via skhd. |

### Other

| Config | Tool | What it does |
|--------|------|-------------|
| [`qBittorrent/`](qBittorrent/) | [qBittorrent](https://www.qbittorrent.org/) | Torrent client settings. |
| [`flutter/`](flutter/) | [Flutter](https://flutter.dev/) | Flutter SDK settings. |
| [`fvm/`](fvm/) | [FVM](https://fvm.app/) | Flutter Version Management. |
| [`cagent/`](cagent/) | Cagent | First-run marker. |

## Shortcuts

### Ghostty

| Key | Action |
|-----|--------|
| `Super + 1-9` | Go to tmux window 1-9 |
| `Super + t` | New tmux window |
| `Super + w` | Close tmux pane |
| `Super + r` | Rename tmux window |
| `Super + p` | Previous tmux window |
| `Super + h` | Previous tmux window |
| `Super + l` | Next tmux window |
| `Super + z` | Zoom tmux pane |
| `Shift + Enter` | Insert newline |

### tmux

Prefix: `C-Space`

#### Windows & sessions

| Key | Action |
|-----|--------|
| `prefix + c` | New window |
| `prefix + ,` | Rename window (sticks permanently) |
| `prefix + T` | Sesh session picker |
| `prefix + 1-9` | Go to window N |
| `Shift-Left/Right` | Prev/next window |
| `C-Shift-H/L` | Prev/next window |
| `prefix + r` | Reload config |
| `prefix + I` | Install plugins (TPM) |

#### Panes

| Key | Action |
|-----|--------|
| `prefix + "` | Split vertical (cwd) |
| `prefix + %` | Split horizontal (cwd) |
| `prefix + h/j/k/l` | Focus pane |
| `C-h/j/k/l` | Focus pane (works in vim too, no prefix) |
| `prefix + H/J/K/L` | Resize pane (repeatable) |
| `prefix + z` | Toggle pane zoom |

#### Copy mode (vi)

Enter with `prefix + [`, exit with `q`.

| Key | Action |
|-----|--------|
| `v` | Begin selection |
| `C-v` | Toggle rectangle select |
| `y` | Yank and exit |
| `/` | Search forward |
| `?` | Search backward |

#### Sesh picker (`prefix + T`)

| Key | Action |
|-----|--------|
| `C-a` | List all |
| `C-t` | Tmux sessions only |
| `C-g` | Config dirs |
| `C-x` | Zoxide dirs |
| `C-f` | Find directories |
| `C-d` | Kill selected session |

### macOS window management (skhd + yabai)

#### Launching

| Key | Action |
|-----|--------|
| `Cmd + Return` | Open Ghostty |
| `Cmd + Alt + Return` | Focus Ghostty |
| `Ctrl + N` | Perpetual note (opens on space 6) |

#### Focus

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus window west/south/north/east |
| `Ctrl + f` | Toggle fullscreen zoom |

#### Spaces (two layouts — pick either)

| Key | Action |
|-----|--------|
| `Alt + 1-9, 0` | Focus space 1-10 |
| `Alt + a/s/d/f` | Focus space 1-4 (home row) |
| `Alt + q/w/e/r` | Focus space 5-8 (top row) |
| `Alt + z` | Focus space 9 |

#### Move windows

| Key | Action |
|-----|--------|
| `Shift + Alt + h/j/k/l` | Swap window in direction |
| `Shift + Cmd + h/j/k/l` | Warp (reparent) window |
| `Shift + Alt + 1-9` | Send window to space N |
| `Shift + Alt + a/s/d/f` | Send window to space 1-4 |
| `Shift + Alt + q/w/e/r` | Send window to space 5-8 |

#### Layout

| Key | Action |
|-----|--------|
| `Ctrl + Alt + e` | Toggle split direction |
| `Alt + y` | Mirror y-axis |
| `Ctrl + Alt + t` | Toggle float + center |
| `Shift + Alt + 0` | Balance all windows |
| `Alt + -` | Shrink window width |
| `Alt + =` | Grow window width |
| `Shift + Alt + j/k` | Grow/shrink window height |
| `Ctrl + Alt + Cmd + r` | Restart yabai |

### Shell (zsh)

#### Aliases

| Alias | Command |
|-------|---------|
| `v` | `nvim` |
| `ls` | `eza` |
| `ll` | `eza -alF --icons` |
| `la` | `eza -a` |
| `cd` | `z` (zoxide — learns your frecent dirs) |
| `fg` | `flutter pub run build_runner build --delete-conflicting-outputs` |
| `lsusb` | `ioreg -p IOUSB` |

#### fzf (fuzzy finder)

| Key | Action |
|-----|--------|
| `C-t` | Fuzzy find files (with bat/eza preview) |
| `Alt-c` | Fuzzy cd into directory (with tree preview) |
| `C-r` | Fuzzy search shell history |
| `**<Tab>` | Fuzzy complete paths, pids, ssh hosts, env vars |
| `Up/Down` | Search history matching current input |

#### Other

| Command | What it does |
|---------|-------------|
| `fuck` | Correct previous command (thefuck) |
| `z <dir>` | Jump to frecent directory (zoxide) |

### Shell (fish)

#### Abbreviations (expand inline as you type)

| Abbr | Expands to |
|------|-----------|
| `gs` | `git status` |
| `ga` | `git add` |
| `gcm` | `git commit -m` |
| `gp` | `git push` |
| `gl` | `git pull` |
| `gd` | `git diff` |
| `gco` | `git checkout` |
| `glog` | `git log --oneline --graph --decorate` |
| `fr` | `flutter run` |
| `fc` | `flutter clean` |
| `fpg` | `flutter pub get` |
| `fbr` | `flutter pub run build_runner build` |
| `gor` | `go run` |
| `gob` | `go build` |
| `got` | `go test` |
| `gomt` | `go mod tidy` |
| `dc` | `docker compose` |
| `dcu` | `docker compose up` |
| `dcd` | `docker compose down` |
| `bri` | `brew install` |
| `bru` | `brew update && brew upgrade` |
| `!!` | Re-run last command |
| `..` / `...` / `....` | cd up 1/2/3 levels |

#### Custom functions

| Command | What it does |
|---------|-------------|
| `take <dir>` | `mkdir -p` + `cd` in one step |
| `extract <file>` | Extract any archive (tar, zip, 7z, rar, gz, bz2) |
| `flutter_new <name>` | Scaffold Flutter project (android+ios, org: dev.codrut) |
| `go_new <name>` | Create Go module with `main.go` |
| `fzf_kill` | Fuzzy select and kill a process |
| `note [name]` | Open/create a markdown note in `~/Notes` via fzf |

### IdeaVim (JetBrains)

Leader: `Space`

#### Navigation

| Key | Action |
|-----|--------|
| `C-h/j/k/l` | Window navigation |
| `S-h` / `S-l` | Previous/next tab |
| `[[` / `]]` | Previous/next method |
| `]e` / `[e` | Next/previous error |
| `]c` / `[c` | Next/previous VCS change |
| `=c` | Show current VCS change |
| `gb` | Back (navigate back) |
| `gf` | Forward |
| `gD` | Go to type declaration |
| `gr` | Find usages |
| `gh` | Show hover info |
| `gL` | Quick implementations |
| `s` | Flash search |

#### Actions

| Key | Action |
|-----|--------|
| `<leader>d` | Debug |
| `<leader>rn` | Rename element |
| `<leader>f` | Reformat code |
| `<leader>b` | Toggle breakpoint |
| `<leader>o` | File structure popup |
| `<leader>c` | Show intention actions (quick fix) |
| `<leader>z` | Toggle distraction-free mode |
| `<leader>a` | Annotate (git blame) |
| `<leader>h` | Highlight usages in file |
| `<leader>s` | Select in project view |
| `<leader>u` | Find usages |
| `<leader>t` | Type hierarchy |
| `<leader>x` | Hide all tool windows |
| `<leader>ff` | Find in path |
| `<leader>w` | Extract Flutter widget |
| `<leader>bd` | Close tab |
| `<leader>bo` | Close all tabs in group |
| `S-Space` | Go to next error |
| `V + S-j/k` | Move line down/up |
| `x + <leader>r` | Refactoring quick list |

#### Editing

| Key | Action |
|-----|--------|
| `<leader>d` | Delete without yanking |
| `c` / `C` / `s` / `S` | Change/substitute without yanking |
| `<leader>y` | Yank to system clipboard |
| `<leader>p` | Paste over selection (keep register) |
| `U` | Redo |
| `H` / `L` | Start/end of line |
| `<leader>i` | Toggle case and insert (e.g. `property` -> `getProperty`) |
| `v + <leader>u` | Remove and toggle case |
| `C-n` | Select next occurrence (multi-cursor) |
| `cx{motion}` | Exchange (select, then exchange) |
| `ys` / `cs` / `ds` / `S` | Surround: add/change/delete/visual |
| `gc` / `gcc` | Comment toggle |
| `m<letter>` | Set global mark |
| `'<letter>` | Jump to global mark |
