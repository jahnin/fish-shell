#!/bin/bash

# Run setup for the current user
USERNAME="$(whoami)"
USER_HOME="$HOME"
FASTFETCH_URL="https://github.com/fastfetch-cli/fastfetch/releases/download/2.45.0/fastfetch-linux-amd64.deb"
FASTFETCH_DEB="/tmp/fastfetch.deb"

echo "[*] Updating package lists..."
sudo apt update

# echo "[*] Uninstalling old fish and Oh My Fish..."
# sudo apt remove --purge -y fish
# rm -rf "$USER_HOME/.local/share/omf" "$USER_HOME/.config/omf"
# rm -rf "$USER_HOME/.config/fish"

echo "[*] Installing fish, git, curl, wget, gdebi-core..."
sudo apt install -y fish git curl wget gdebi-core

echo "[*] Downloading fastfetch from GitHub..."
wget -O "$FASTFETCH_DEB" "$FASTFETCH_URL"

echo "[*] Installing fastfetch..."
sudo gdebi -n "$FASTFETCH_DEB"
rm -f "$FASTFETCH_DEB"

echo "[*] Setting fish as default shell..."
FISH_PATH=$(command -v fish)

# Ensure fish is in /etc/shells
if ! grep -qxF "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

# Change default shell
sudo chsh -s "$FISH_PATH" "$USERNAME"

echo "[*] Ensuring proper ownership of config directory..."
sudo mkdir -p "$HOME/.config"
sudo chown -R "$USER:$USER" "$HOME/.config"

echo "[*] Installing Oh My Fish..."
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --noninteractive --path=~/.local/share/omf --config=~/.config/omf

echo "[*] Installing bobthefish theme..."
env HOME="$HOME" fish -l -c 'omf install bobthefish'

echo "[*] Blanking out /etc/motd..."
echo "" | sudo tee /etc/motd >/dev/null

CONFIG_FISH="$USER_HOME/.config/fish/config.fish"
echo "[*] Configuring fastfetch in $CONFIG_FISH..."

mkdir -p "$(dirname "$CONFIG_FISH")"

cat > "$CONFIG_FISH" <<EOF
if status is-interactive
    fastfetch
end
EOF

echo "Fish environment successfully set up for $USERNAME!"
