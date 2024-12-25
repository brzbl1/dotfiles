set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x QT_LOGGING_RULES "qt5ct.debug=false"
# set -x GOPATH $HOME/Script
set -x PATH $PATH GOPATH/bin
set -x EDITOR nvim
#set PATH /usr/bin/nim $PATH
set PATH /home/brzbl/.nimble/bin $PATH
set EDITOR /usr/bin/nvim
set -x RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgreprc
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

function fish_greeting
    #greeting message
end

function su # bash -> fish
    /bin/su --shell=/usr/bin/fish $argv
end

# function cd
#     builtin cd $argv
#     and ls -A --group-directories-first
# end

# cod init $fish_pid fish | source

starship init fish | source

zoxide init fish | source
set -g ZO_DIR $HOME/.config/zoxide
set -g ZO_SEARCH_ALG fuzzy

function rgfind -d 'find with ripgrep'
    rg --files | fzf
end

function del-history
    set lines (builtin history -z|fzf -m --read0 \
      --query=(commandline) \
      --preview="echo {}|fish_indent --ansi" \
      --preview-window="bottom:3:wrap")

    for l in $lines
        eval 'builtin history delete --case-sensitive --exact -- "$l"'
    end

end

function ya
	set tmp (mktemp -t "yazi-cwd.XXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end


alias arix2='aria2c -x2'
# alias unzip='unzip -Osjis'
alias vi='nvim'
alias scl='sudo systemctl'

function fish_mode_prompt
end

function preexec --on-event fish_preexec
    # echo "preexec: $argv[1]"
end

function postexec --on-event fish_postexec
    # echo "postexec: $argv[1] ($status)"
end
