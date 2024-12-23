complete -c mdless -l columns -d 'Maximum number of columns to use for output' -r
complete -c mdless -l completions -d 'Generate completions for a shell to standard output and exit' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c mdless -s c -l no-colour -d 'Disable all colours and other styles'
complete -c mdless -s l -l local -d 'Do not load remote resources like images'
complete -c mdless -l fail -d 'Exit immediately if any error occurs processing an input file'
complete -c mdless -l detect-terminal -d 'Print detected terminal name and exit'
complete -c mdless -l ansi -d 'Skip terminal detection and only use ANSI formatting'
complete -c mdless -s P -l no-pager -d 'Do not paginate output (default for mdcat)'
complete -c mdless -s p -l paginate -d 'Paginate the output of mdcat with a pager like less (default). Overrides an earlier --no-pager'
complete -c mdless -s h -l help -d 'Print help'
complete -c mdless -s V -l version -d 'Print version'
