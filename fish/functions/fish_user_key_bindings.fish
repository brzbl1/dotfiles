function fish_user_key_bindings
    # vim insert mode時には効かない。
    # vim insert mode -> add option "-M insert"
    # 	bind \cj dirtest
    # 	bind \e\[1\;6C dirtest
    # 	bind \ej "dirtest -a"
    # bind -M insert \cm jump
    # bind -M insert \em "jump -a"
    bind -M insert \co 'xdg-open . > /dev/null 2>&1'
    bind -M insert \cn "echo \n ;navi;starship prompt"
    # bind -M insert \cn "clear ; navi"
    # bind \cm jump
    # bind \em "jump -a"
    bind \cn navi #ctrlN
    #bind -M insert \cE nvim #ctrlN
    bind -M insert -k ppage ins-path
    bind -M insert -k btab ins-path
    # bind -M insert \e\[1\;5A "ins-path"
    # bind -M insert \e\[1\;3A "../;starship prompt"
    # 	bind -k ppage comtest
    # 	bind \e\[1\;6D comtest
    # bind \e\[D comtest

    # move
    bind -M insert \e\[1\;3A '../;commandline -f repaint'
    bind \e\[1\;3D 'prevd;commandline -f repaint'
    bind -M insert \e\[1\;3C 'nextd;commandline -f repaint'
end

# fzf_key_bindings
