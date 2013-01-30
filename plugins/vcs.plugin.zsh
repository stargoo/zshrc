# -*- sh -*-

# Incorporate git and svn information into prompt

(( $+functions[add-zsh-hook] )) && {

    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git svn hg
    __() {
        local common='${PRCH[branch]} %b%c%u'
	zstyle ':vcs_info:*:*'   formats $common
	zstyle ':vcs_info:*:*'   actionformats $common'${PRCHR[sep]}'%a
	zstyle ':vcs_info:svn:*' branchformat '%b:%r'
	zstyle ':vcs_info:*:*'   stagedstr     %F{green}${PRCH[circle]}
	zstyle ':vcs_info:*:*'   unstagedstr   %F{yellow}${PRCH[circle]}
	zstyle ':vcs_info:*:*'   check-for-changes true
    } && __

    _vbe_vcs_precmd () {
	vcs_info
    }
    add-zsh-hook precmd _vbe_vcs_precmd
    _vbe_add_prompt_vcs () {
	_vbe_prompt_segment cyan default ${(e)vcs_info_msg_0_}
    }
}
