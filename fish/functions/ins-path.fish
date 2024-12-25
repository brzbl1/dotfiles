function ins-path
    set str (fd -H | fzf \
      --preview="stat {}" \
      --preview-window="bottom:8:wrap")
  # set str (rg --files | fzf)
    # count $str
    if test 1 -eq (count $str)
        commandline -t $str
        commandline -f repaint
    end
end
