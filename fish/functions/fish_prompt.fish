function fish_prompt
    set_color green
    echo -n (prompt_pwd | string replace --regex "^$HOME" '~') ' '
    set_color normal
end

