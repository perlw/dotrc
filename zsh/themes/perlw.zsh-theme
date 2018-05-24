local ret_status="%(?:%{$reset_color%}:%{$fg_bold[red]%})%?"
local jobs_status="%{$reset_color%}%j"
PROMPT='(%{$fg_bold[blue]%}%m%{$reset_color%}:%{$fg_bold[cyan]%}%c%{$reset_color%})[${ret_status} ${jobs_status}%{$reset_color%}] $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="⌥%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}‼"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
