complete -c mdcat -l columns -d 'Maximum number of columns to use for output' -r
complete -c mdcat -l completions -d 'Generate completions for a shell to standard output and exit' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c mdcat -s c -l no-colour -d 'Disable all colours and other styles'
complete -c mdcat -s l -l local -d 'Do not load remote resources like images'
complete -c mdcat -l fail -d 'Exit immediately if any error occurs processing an input file'
complete -c mdcat -l detect-terminal -d 'Print detected terminal name and exit'
complete -c mdcat -l ansi -d 'Skip terminal detection and only use ANSI formatting'
complete -c mdcat -s p -l paginate -d 'Paginate the output of mdcat with a pager like less (default for mdless)'
complete -c mdcat -s P -l no-pager -d 'Do not paginate output (default). Overrides an earlier --paginate'
complete -c mdcat -s h -l help -d 'Print help'
complete -c mdcat -s V -l version -d 'Print version'
