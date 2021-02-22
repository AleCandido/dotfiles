# ╔══════════════════════════╗
# ║ My .zshrc further stuffs ║
# ╚══════════════════════════╝

# virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# vim sessions script (not compatible with bash)
source $HOME/.bin/vims.sh

# ┌───┐
# │nnn│
# └───┘

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# ╔═════════════════════╗
# ║ Zsh-related configs ║
# ╚═════════════════════╝

# ┌───────────────────────────────┐
# │From arch-wiki/zsh#key_bindings│
# └───────────────────────────────┘
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
#typeset -g -A key

#key[Home]="${terminfo[khome]}"
#key[End]="${terminfo[kend]}"
#key[Insert]="${terminfo[kich1]}"
#key[Backspace]="${terminfo[kbs]}"
#key[Delete]="${terminfo[kdch1]}"
#key[Up]="${terminfo[kcuu1]}"
#key[Down]="${terminfo[kcud1]}"
#key[Left]="${terminfo[kcub1]}"
#key[Right]="${terminfo[kcuf1]}"
#key[PageUp]="${terminfo[kpp]}"
#key[PageDown]="${terminfo[knp]}"
#key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
#[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
#[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
#[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
#[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
#[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
#[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
#[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
#[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
#[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
#[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
#[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
#if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  #autoload -Uz add-zle-hook-widget
  #function zle_application_mode_start { echoti smkx }
  #function zle_application_mode_stop { echoti rmkx }
  #add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  #add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
#fi

# ┌────────────┐
# │Home and End│
# └────────────┘

bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line


# ┌──────────────────┐
# │HSTR configuration│
# └──────────────────┘
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# [PageUp] - Up a line of history
if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey "${terminfo[kpp]}" up-line-or-history
  bindkey -a "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey "${terminfo[knp]}" down-line-or-history
  bindkey -a "${terminfo[knp]}" down-line-or-history
fi


# ╔══════╗
# ║ Misc ║
# ╚══════╝

# ---------------
# suppress shared history
# ---------------
setopt extendedglob

# ---------------
# suppress shared history
# ---------------
unsetopt share_history

# ---------------
# screensaver
# ---------------
# TMOUT=1800

# TRAPALRM() {
     #cmatrix -s
# }

# ╔══════════════════════════════════════╗
# ║ Stuffs executed just before entering ║
# ╚══════════════════════════════════════╝
