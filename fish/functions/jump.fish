#!/usr/bin/fish

function jump
	set str (commandline -b) #コマンドラインにある文字列のチェック
	if contains -- -a $argv
		set str (find -maxdepth 1 -type d | awk 'NR>1{print $0}' | sort |fzf --ansi --no-info --height=50% --reverse --cycle)
	else
		set str (find -maxdepth 1 -type d ! -name '.*' | sort |fzf --ansi --no-info --height=50% --reverse --cycle)
	end

	if test $status -eq 0
		if test -d $str
			pushd $str
		end
	else

	end
	commandline -f repaint
end
