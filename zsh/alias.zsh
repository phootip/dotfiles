alias watch='watch '
alias loadnvm="source $NVM_DIR/nvm.sh"
alias vim="nvim"

# https://unix.stackexchange.com/questions/236094/how-to-remove-the-last-command-or-current-command-for-bonus-from-zsh-history
alias forget=' my_remove_last_history_entry'
my_remove_last_history_entry() {
    is_int() ( return $(test "$@" -eq "$@" > /dev/null 2>&1); )
    history_file="${HOME}/.zsh_history"
    history_temp_file="${history_file}.tmp"
    line_cout=$(wc -l $history_file | awk '{print $1;}')
    lines_to_remove=1
    if [ $# -eq 0 ]; then
        lines_to_remove=1
    else
        if $(is_int "${1}"); then
            lines_to_remove="$1"
        else
            echo "Unknown argument passed. Exiting..."
            return
        fi
    fi
    lines_to_remove=$(($line_cout-$lines_to_remove))
    echo $lines_to_remove
    fc -W
    cat $history_file | head -n "${lines_to_remove}" &> $history_temp_file
    mv "$history_temp_file" "$history_file"
    fc -R
}
