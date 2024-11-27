complete -c procs -s W -l watch-interval -d 'Watch mode with custom interval' -r
complete -c procs -s i -l insert -d 'Insert column to slot' -r
complete -c procs -l only -d 'Specified column only' -r
complete -c procs -l sorta -d 'Sort column by ascending' -r
complete -c procs -l sortd -d 'Sort column by descending' -r
complete -c procs -s c -l color -d 'Color mode' -r -f -a "{auto\t'',always\t'',disable\t''}"
complete -c procs -l theme -d 'Theme mode' -r -f -a "{auto\t'',dark\t'',light\t''}"
complete -c procs -s p -l pager -d 'Pager mode' -r -f -a "{auto\t'',always\t'',disable\t''}"
complete -c procs -l interval -d 'Interval to calculate throughput' -r
complete -c procs -l use-config -d 'Use built-in configuration' -r -f -a "{default\t'',large\t''}"
complete -c procs -l load-config -d 'Load configuration from file' -r -F
complete -c procs -l gen-completion -d 'Generate shell completion file' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c procs -l gen-completion-out -d 'Generate shell completion file and write to stdout' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c procs -l procfs -d 'Path to procfs' -r -F
complete -c procs -s a -l and -d 'AND  logic for multi-keyword'
complete -c procs -s o -l or -d 'OR   logic for multi-keyword'
complete -c procs -s d -l nand -d 'NAND logic for multi-keyword'
complete -c procs -s r -l nor -d 'NOR  logic for multi-keyword'
complete -c procs -s l -l list -d 'Show list of kind'
complete -c procs -l thread -d 'Show thread'
complete -c procs -s t -l tree -d 'Tree view'
complete -c procs -s w -l watch -d 'Watch mode with default interval (1s)'
complete -c procs -l gen-config -d 'Generate configuration sample file'
complete -c procs -l no-header -d 'Suppress header'
complete -c procs -l debug -d 'Show debug message'
complete -c procs -s h -l help -d 'Print help (see more with \'--help\')'
complete -c procs -s V -l version -d 'Print version'
