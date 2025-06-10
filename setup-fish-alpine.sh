#!/bin/bash

# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

# Check for username argument
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME="$1"
USER_HOME="/home/$USERNAME"

# Verify user exists
if ! id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME does not exist."
    exit 1
fi

echo "[*] Installing fish shell, git, and fastfetch..."
apk add fish git fastfetch shadow curl

echo "[*] Changing default shell to fish for $USERNAME..."
FISH_PATH=$(which fish)

# Ensure fish is in /etc/shells
grep -qxF "$FISH_PATH" /etc/shells || echo "$FISH_PATH" >> /etc/shells

# Change user shell
chsh -s "$FISH_PATH" "$USERNAME"

echo "[*] Installing Oh My Fish..."
sudo -u "$USERNAME" fish -c 'curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish'

echo "[*] Installing bobthefish theme..."
sudo -u "$USERNAME" fish -c 'omf install bobthefish'

echo "[*] Blanking out /etc/motd..."
> /etc/motd

CONFIG_FISH="$USER_HOME/.config/fish/config.fish"
echo "[*] Configuring fastfetch in $CONFIG_FISH..."

# Ensure config directory exists
mkdir -p "$(dirname "$CONFIG_FISH")"
chown -R "$USERNAME:$USERNAME" "$(dirname "$CONFIG_FISH")"

# Add fastfetch to config.fish
sudo -u "$USERNAME" bash -c "cat > \"$CONFIG_FISH\" <<EOF
if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end
EOF"

echo "Setup complete for user $USERNAME!"
