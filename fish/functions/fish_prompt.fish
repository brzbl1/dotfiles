function fish_prompt
    set -l laststatus $status
    test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = root
    and echo (set_color red)"#"

    # set -l clr1 brblue
    set -l bgclr 222
    set -l bgclr2 C11

    set_color -b $bgclr
    #printf (date "+%T ")
    # OS icon
    #     set -l os (cat /etc/lsb-release | grep "_ID" | awk -F'=' '{print $2}')
    #     switch $os
    #         case \"Arch\"
    #             set_color 28f
    #             set_color -b $bgclr
    #             printf '   '
    #         case LinuxMint
    #             set_color 7f7 #brgreen
    #             set_color -b $bgclr
    #             printf '   '
    #     end

    if test "$fish_key_bindings" = fish_vi_key_bindings
        # set -l mode
        switch $fish_bind_mode
            case default
                echo -n (set_color white)" "
            case insert
                echo -n (set_color white)"ﲵ "
            case visual
                echo -n (set_color white)" "
        end
    end

    set_color $bgclr2 #$bgclr
    set_color -b 800
    printf ''
    set_color normal

    #current dir
    set_color ff0 #bryellow
    set_color -b $bgclr2
    #    if test $HOME = (pwd)
    #     printf " "
    #    else if test (ls -la | awk 'NR==2 {print $1}'|cut -c 6-6) = -
    # else if test (ls -o | awk 'NR==2 {print $3}') != (whoami)
    #   printf " "
    # else
    #     printf " "
    # end

    # Main
    # set_color -b
    echo -n (prompt_pwd)

    set_color -b normal
    set_color $bgclr2
    printf ''

    set_color normal
    # echo -n (date +"%H:%M:%S")(set_color bryellow)(prompt_pwd) #(set_color brred)'❯'(set_color bryellow)'❯'(set_color brgreen)'❯ '

    function my_postexec --on-event fish_postexec
        set -l laststatus $status
        if test $laststatus -ne 0
            # echo "postexec: $argv[1] ($status)"
            set_color -o red
            echo Error: $laststatus
            set_color normal
        end

        if test $laststatus -eq 127
            builtin history delete --case-sensitive --exact -- $argv
        end

        switch (date "+%H")
            case 00
                printf 九ツ
            case 01
                printf 九ツ半
            case 02
                printf 八ツ
            case 03
                printf 八ツ半
            case 04
                printf 七ツ
            case 05
                printf 七ツ半
            case 06
                printf 六ツ
            case 07
                printf 六ツ半
            case 08
                printf 五ツ
            case 09
                printf 五ツ半
            case 10
                printf 四ツ
            case 11
                printf 四ツ半
            case 12
                printf 九ツ
            case 13
                printf 九ツ半
            case 14
                printf 八ツ
            case 15
                printf 八ツ半
            case 16
                printf 七ツ
            case 17
                printf 七ツ半
            case 18
                printf 六ツ
            case 19
                printf 六ツ半
            case 20
                printf 五ツ
            case 21
                printf 五ツ半
            case 22
                printf 四ツ
            case 23
                printf 四ツ半
        end
        echo (date "+%M:%S ")
    end

end


function not_found --on-event fish_command_not_found
    echo not_found
end

#     function fish_right_prompt
#         sleep 0.2
#         set -l laststatus $status
#         if test $laststatus -eq 0
#             printf "%s✔ " (set_color -o green)
#         else
#             printf "%s✘ " (set_color -o red)
#         end
#
#         date "+%T "
#     #	echo -n (date +"%H:%M:%S")
#     end
