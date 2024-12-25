#!/usr/bin/fish

function dirtest
	# function nagasa -S
	# 	set lng 0
	# 	for son in $dir
	# 		set i (count (find $son -maxdepth 1 ! -name '.*'))
	# 		if test (string length $i) -gt $lng
	# 			set lng (string length $i)
	# 		end
	# 	end
	# 	echo $lng
	# end

	function list -S
		# set lng (nagasa)
		for son in $dir
			# set i (count (find $son -maxdepth 1 ! -name '.*'))
			echo $son
			# printf (string join "" '%' $lng 'd|%s\n') $i $son
		end
	end

	set -l nm (contains -- -a $argv;and echo .;or echo '.*';)
	set -l dir (find -maxdepth 1 -type d ! -name $nm | sort)

	set str (list | fzf --ansi --no-info --height=50% --reverse --cycle \
	--preview 'ls -GHCNhgp --group-directories-first --time-style=iso {}' \
	)
	# test -d $str; and pushd $str
	if test $status -eq 0
		# set to (string split '|' $str)[2]
		# test -d $to; and pushd $to
		test -d $str; and pushd $str
	else

	end

	commandline -f repaint
end
