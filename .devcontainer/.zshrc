# 1. Enable version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Enable prompt substitution to allow variables in the prompt
setopt PROMPT_SUBST

# 2. Format the Git branch output
# Enable git support for vcs_info
zstyle ':vcs_info:*' enable git
# Displays ' (branch-name)' in green if inside a Git repo
zstyle ':vcs_info:git:*' formats ' (%F{green}%b%f)'

# 3. Define the prompt appearance
# %F{cyan}%~%f = Current directory in cyan
# ${vcs_info_msg_0_} = Git branch placeholder
# %F{yellow}$%f = Prompt symbol ($) in yellow
PROMPT='%F{cyan}%~%f${vcs_info_msg_0_} %F{yellow}$%f '
