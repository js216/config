# ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
ssh-add -l &>/dev/null
if [ $? -eq 2 ]; then
   rm -f "$SSH_AUTH_SOCK"
   eval "$(ssh-agent -a "$SSH_AUTH_SOCK" -s)" > /dev/null
fi

# PATH
. "$HOME/.cargo/env"
export PATH="/opt/llvm22/bin:$HOME/.local/bin:$PATH"

source ~/.bashrc
