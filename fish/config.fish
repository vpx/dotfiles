if status is-interactive
# Commands to run in interactive sessions can go here
end

if not set -q TMUX
    tmux new-session
end

set -g fish_greeting

