# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_atuin_global_optspecs
	string join \n h/help V/version
end

function __fish_atuin_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_atuin_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_atuin_using_subcommand
	set -l cmd (__fish_atuin_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c atuin -n "__fish_atuin_needs_command" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_needs_command" -s V -l version -d 'Print version'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "history" -d 'Manipulate shell history'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "import" -d 'Import shell history from file'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "stats" -d 'Calculate statistics for your history'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "search" -d 'Interactive history search'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "sync" -d 'Sync with the configured server'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "login" -d 'Login to the configured server'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "logout" -d 'Log out'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "register" -d 'Register with the configured server'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "key" -d 'Print the encryption key for transfer to another machine'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "status" -d 'Display the sync status'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "account" -d 'Manage your sync account'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "kv" -d 'Get or set small key-value pairs'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "store" -d 'Manage the atuin data store'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "dotfiles" -d 'Manage your dotfiles with Atuin'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "init" -d 'Print Atuin\'s shell init script'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "info" -d 'Information about dotfiles locations and ENV vars'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "doctor" -d 'Run the doctor to check for common issues'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "wrapped"
complete -c atuin -n "__fish_atuin_needs_command" -f -a "daemon" -d '*Experimental* Start the background daemon'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "default-config" -d 'Print the default atuin configuration (config.toml)'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "server" -d 'Start an atuin server'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "uuid" -d 'Generate a UUID'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "contributors"
complete -c atuin -n "__fish_atuin_needs_command" -f -a "gen-completions" -d 'Generate shell completions'
complete -c atuin -n "__fish_atuin_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -f -a "start" -d 'Begins a new command in the history'
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -f -a "end" -d 'Finishes a new command in the history (adds time, exit code)'
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -f -a "list" -d 'List all items in history'
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -f -a "last" -d 'Get the last command ran'
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -f -a "init-store"
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -f -a "prune" -d 'Delete history entries matching the configured exclusion filters'
complete -c atuin -n "__fish_atuin_using_subcommand history; and not __fish_seen_subcommand_from start end list last init-store prune help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from start" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from end" -s e -l exit -r
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from end" -s d -l duration -r
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from end" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -s r -l reverse -r -f -a "{true\t'',false\t''}"
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -l timezone -l tz -d 'Display the command time in another timezone other than the configured default' -r
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -s f -l format -d 'Available variables: {command}, {directory}, {duration}, {user}, {host}, {exit} and {time}. Example: --format "{time} - [{duration}] - {directory}$\\t{command}"' -r
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -s c -l cwd
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -s s -l session
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -l human
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -l cmd-only -d 'Show only the text of the command'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -l print0 -d 'Terminate the output with a null, for better multiline support'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from last" -l timezone -l tz -d 'Display the command time in another timezone other than the configured default' -r
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from last" -s f -l format -d 'Available variables: {command}, {directory}, {duration}, {user}, {host} and {time}. Example: --format "{time} - [{duration}] - {directory}$\\t{command}"' -r
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from last" -l human
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from last" -l cmd-only -d 'Show only the text of the command'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from last" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from init-store" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from prune" -s n -l dry-run -d 'List matching history lines without performing the actual deletion'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from prune" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "start" -d 'Begins a new command in the history'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "end" -d 'Finishes a new command in the history (adds time, exit code)'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all items in history'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "last" -d 'Get the last command ran'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "init-store"
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "prune" -d 'Delete history entries matching the configured exclusion filters'
complete -c atuin -n "__fish_atuin_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "auto" -d 'Import history for the current shell'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "zsh" -d 'Import history from the zsh history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "zsh-hist-db" -d 'Import history from the zsh history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "bash" -d 'Import history from the bash history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "replxx" -d 'Import history from the replxx history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "resh" -d 'Import history from the resh history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "fish" -d 'Import history from the fish history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "nu" -d 'Import history from the nu history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "nu-hist-db" -d 'Import history from the nu history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "xonsh" -d 'Import history from xonsh json files'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "xonsh-sqlite" -d 'Import history from xonsh sqlite db'
complete -c atuin -n "__fish_atuin_using_subcommand import; and not __fish_seen_subcommand_from auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from auto" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from zsh" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from zsh-hist-db" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from bash" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from replxx" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from resh" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from fish" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from nu" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from nu-hist-db" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from xonsh" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from xonsh-sqlite" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "auto" -d 'Import history for the current shell'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "zsh" -d 'Import history from the zsh history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "zsh-hist-db" -d 'Import history from the zsh history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "bash" -d 'Import history from the bash history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "replxx" -d 'Import history from the replxx history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "resh" -d 'Import history from the resh history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "fish" -d 'Import history from the fish history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "nu" -d 'Import history from the nu history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "nu-hist-db" -d 'Import history from the nu history file'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "xonsh" -d 'Import history from xonsh json files'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "xonsh-sqlite" -d 'Import history from xonsh sqlite db'
complete -c atuin -n "__fish_atuin_using_subcommand import; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand stats" -s c -l count -d 'How many top commands to list' -r
complete -c atuin -n "__fish_atuin_using_subcommand stats" -s n -l ngram-size -d 'The number of consecutive commands to consider' -r
complete -c atuin -n "__fish_atuin_using_subcommand stats" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand search" -s c -l cwd -d 'Filter search result by directory' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -l exclude-cwd -d 'Exclude directory from results' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -s e -l exit -d 'Filter search result by exit code' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -l exclude-exit -d 'Exclude results with this exit code' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -s b -l before -d 'Only include results added before this date' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -l after -d 'Only include results after this date' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -l limit -d 'How many entries to return at most' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -l offset -d 'Offset from the start of the results' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -l filter-mode -d 'Allow overriding filter mode over config' -r -f -a "{global\t'',host\t'',session\t'',directory\t'',workspace\t''}"
complete -c atuin -n "__fish_atuin_using_subcommand search" -l search-mode -d 'Allow overriding search mode over config' -r -f -a "{prefix\t'',full-text\t'',fuzzy\t'',skim\t''}"
complete -c atuin -n "__fish_atuin_using_subcommand search" -l keymap-mode -d 'Notify the keymap at the shell\'s side' -r -f -a "{emacs\t'',vim-normal\t'',vim-insert\t'',auto\t''}"
complete -c atuin -n "__fish_atuin_using_subcommand search" -l timezone -l tz -d 'Display the command time in another timezone other than the configured default' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -s f -l format -d 'Available variables: {command}, {directory}, {duration}, {user}, {host}, {time}, {exit} and {relativetime}. Example: --format "{time} - [{duration}] - {directory}$\\t{command}"' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -l inline-height -d 'Set the maximum number of lines Atuin\'s interface should take up' -r
complete -c atuin -n "__fish_atuin_using_subcommand search" -s i -l interactive -d 'Open interactive search UI'
complete -c atuin -n "__fish_atuin_using_subcommand search" -l shell-up-key-binding -d 'Marker argument used to inform atuin that it was invoked from a shell up-key binding (hidden from help to avoid confusion)'
complete -c atuin -n "__fish_atuin_using_subcommand search" -l human -d 'Use human-readable formatting for time'
complete -c atuin -n "__fish_atuin_using_subcommand search" -l cmd-only -d 'Show only the text of the command'
complete -c atuin -n "__fish_atuin_using_subcommand search" -l delete -d 'Delete anything matching this query. Will not print out the match'
complete -c atuin -n "__fish_atuin_using_subcommand search" -l delete-it-all -d 'Delete EVERYTHING!'
complete -c atuin -n "__fish_atuin_using_subcommand search" -s r -l reverse -d 'Reverse the order of results, oldest first'
complete -c atuin -n "__fish_atuin_using_subcommand search" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c atuin -n "__fish_atuin_using_subcommand sync" -s f -l force -d 'Force re-download everything'
complete -c atuin -n "__fish_atuin_using_subcommand sync" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand login" -s u -l username -r
complete -c atuin -n "__fish_atuin_using_subcommand login" -s p -l password -r
complete -c atuin -n "__fish_atuin_using_subcommand login" -s k -l key -d 'The encryption key for your account' -r
complete -c atuin -n "__fish_atuin_using_subcommand login" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand logout" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand register" -s u -l username -r
complete -c atuin -n "__fish_atuin_using_subcommand register" -s p -l password -r
complete -c atuin -n "__fish_atuin_using_subcommand register" -s e -l email -r
complete -c atuin -n "__fish_atuin_using_subcommand register" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand key" -l base64 -d 'Switch to base64 output of the key'
complete -c atuin -n "__fish_atuin_using_subcommand key" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand status" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -f -a "login" -d 'Login to the configured server'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -f -a "register" -d 'Register a new account'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -f -a "logout" -d 'Log out'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -f -a "delete" -d 'Delete your account, and all synced data'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -f -a "change-password" -d 'Change your password'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -f -a "verify" -d 'Verify your account'
complete -c atuin -n "__fish_atuin_using_subcommand account; and not __fish_seen_subcommand_from login register logout delete change-password verify help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from login" -s u -l username -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from login" -s p -l password -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from login" -s k -l key -d 'The encryption key for your account' -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from login" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from register" -s u -l username -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from register" -s p -l password -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from register" -s e -l email -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from register" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from logout" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from change-password" -s c -l current-password -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from change-password" -s n -l new-password -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from change-password" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from verify" -s t -l token -r
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from verify" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from help" -f -a "login" -d 'Login to the configured server'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from help" -f -a "register" -d 'Register a new account'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from help" -f -a "logout" -d 'Log out'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete your account, and all synced data'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from help" -f -a "change-password" -d 'Change your password'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from help" -f -a "verify" -d 'Verify your account'
complete -c atuin -n "__fish_atuin_using_subcommand account; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand kv; and not __fish_seen_subcommand_from set get list help" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand kv; and not __fish_seen_subcommand_from set get list help" -f -a "set"
complete -c atuin -n "__fish_atuin_using_subcommand kv; and not __fish_seen_subcommand_from set get list help" -f -a "get"
complete -c atuin -n "__fish_atuin_using_subcommand kv; and not __fish_seen_subcommand_from set get list help" -f -a "list"
complete -c atuin -n "__fish_atuin_using_subcommand kv; and not __fish_seen_subcommand_from set get list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from set" -s k -l key -r
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from set" -s n -l namespace -r
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from set" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from get" -s n -l namespace -r
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from list" -s n -l namespace -r
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from list" -s a -l all-namespaces
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from help" -f -a "set"
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from help" -f -a "get"
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from help" -f -a "list"
complete -c atuin -n "__fish_atuin_using_subcommand kv; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "status" -d 'Print the current status of the record store'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "rebuild" -d 'Rebuild a store (eg atuin store rebuild history)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "rekey" -d 'Re-encrypt the store with a new key (potential for data loss!)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "purge" -d 'Delete all records in the store that cannot be decrypted with the current key'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "verify" -d 'Verify that all records in the store can be decrypted with the current key'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "push" -d 'Push all records to the remote sync server (one way sync)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "pull" -d 'Pull records from the remote sync server (one way sync)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and not __fish_seen_subcommand_from status rebuild rekey purge verify push pull help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from rebuild" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from rekey" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from purge" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from verify" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from push" -s t -l tag -d 'The tag to push (eg, \'history\'). Defaults to all tags' -r
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from push" -l host -d 'The host to push, in the form of a UUID host ID. Defaults to the current host' -r
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from push" -l force -d 'Force push records This will override both host and tag, to be all hosts and all tags. First clear the remote store, then upload all of the local store'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from push" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from pull" -s t -l tag -d 'The tag to push (eg, \'history\'). Defaults to all tags' -r
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from pull" -l force -d 'Force push records This will first wipe the local store, and then download all records from the remote'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from pull" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "status" -d 'Print the current status of the record store'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "rebuild" -d 'Rebuild a store (eg atuin store rebuild history)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "rekey" -d 'Re-encrypt the store with a new key (potential for data loss!)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "purge" -d 'Delete all records in the store that cannot be decrypted with the current key'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "verify" -d 'Verify that all records in the store can be decrypted with the current key'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "push" -d 'Push all records to the remote sync server (one way sync)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "pull" -d 'Pull records from the remote sync server (one way sync)'
complete -c atuin -n "__fish_atuin_using_subcommand store; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and not __fish_seen_subcommand_from alias var help" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and not __fish_seen_subcommand_from alias var help" -f -a "alias" -d 'Manage shell aliases with Atuin'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and not __fish_seen_subcommand_from alias var help" -f -a "var" -d 'Manage shell and environment variables with Atuin'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and not __fish_seen_subcommand_from alias var help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from alias" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from alias" -f -a "set" -d 'Set an alias'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from alias" -f -a "delete" -d 'Delete an alias'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from alias" -f -a "list" -d 'List all aliases'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from alias" -f -a "clear" -d 'Delete all aliases'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from alias" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from var" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from var" -f -a "set" -d 'Set a variable'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from var" -f -a "delete" -d 'Delete a variable'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from var" -f -a "list" -d 'List all variables'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from var" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from help" -f -a "alias" -d 'Manage shell aliases with Atuin'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from help" -f -a "var" -d 'Manage shell and environment variables with Atuin'
complete -c atuin -n "__fish_atuin_using_subcommand dotfiles; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand init" -l disable-ctrl-r -d 'Disable the binding of CTRL-R to atuin'
complete -c atuin -n "__fish_atuin_using_subcommand init" -l disable-up-arrow -d 'Disable the binding of the Up Arrow key to atuin'
complete -c atuin -n "__fish_atuin_using_subcommand init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c atuin -n "__fish_atuin_using_subcommand info" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand doctor" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand wrapped" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand daemon" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand default-config" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand server; and not __fish_seen_subcommand_from start default-config help" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand server; and not __fish_seen_subcommand_from start default-config help" -f -a "start" -d 'Start the server'
complete -c atuin -n "__fish_atuin_using_subcommand server; and not __fish_seen_subcommand_from start default-config help" -f -a "default-config" -d 'Print server example configuration'
complete -c atuin -n "__fish_atuin_using_subcommand server; and not __fish_seen_subcommand_from start default-config help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand server; and __fish_seen_subcommand_from start" -l host -d 'The host address to bind' -r
complete -c atuin -n "__fish_atuin_using_subcommand server; and __fish_seen_subcommand_from start" -s p -l port -d 'The port to bind' -r
complete -c atuin -n "__fish_atuin_using_subcommand server; and __fish_seen_subcommand_from start" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand server; and __fish_seen_subcommand_from default-config" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand server; and __fish_seen_subcommand_from help" -f -a "start" -d 'Start the server'
complete -c atuin -n "__fish_atuin_using_subcommand server; and __fish_seen_subcommand_from help" -f -a "default-config" -d 'Print server example configuration'
complete -c atuin -n "__fish_atuin_using_subcommand server; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand uuid" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand contributors" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand gen-completions" -s s -l shell -d 'Set the shell for generating completions' -r -f -a "{bash\t'',elvish\t'',fish\t'',nushell\t'',powershell\t'',zsh\t''}"
complete -c atuin -n "__fish_atuin_using_subcommand gen-completions" -s o -l out-dir -d 'Set the output directory' -r
complete -c atuin -n "__fish_atuin_using_subcommand gen-completions" -s h -l help -d 'Print help'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "history" -d 'Manipulate shell history'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "import" -d 'Import shell history from file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "stats" -d 'Calculate statistics for your history'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "search" -d 'Interactive history search'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "sync" -d 'Sync with the configured server'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "login" -d 'Login to the configured server'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "logout" -d 'Log out'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "register" -d 'Register with the configured server'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "key" -d 'Print the encryption key for transfer to another machine'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "status" -d 'Display the sync status'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "account" -d 'Manage your sync account'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "kv" -d 'Get or set small key-value pairs'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "store" -d 'Manage the atuin data store'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "dotfiles" -d 'Manage your dotfiles with Atuin'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "init" -d 'Print Atuin\'s shell init script'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "info" -d 'Information about dotfiles locations and ENV vars'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "doctor" -d 'Run the doctor to check for common issues'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "wrapped"
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "daemon" -d '*Experimental* Start the background daemon'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "default-config" -d 'Print the default atuin configuration (config.toml)'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "server" -d 'Start an atuin server'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "uuid" -d 'Generate a UUID'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "contributors"
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "gen-completions" -d 'Generate shell completions'
complete -c atuin -n "__fish_atuin_using_subcommand help; and not __fish_seen_subcommand_from history import stats search sync login logout register key status account kv store dotfiles init info doctor wrapped daemon default-config server uuid contributors gen-completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "start" -d 'Begins a new command in the history'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "end" -d 'Finishes a new command in the history (adds time, exit code)'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "list" -d 'List all items in history'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "last" -d 'Get the last command ran'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "init-store"
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "prune" -d 'Delete history entries matching the configured exclusion filters'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "auto" -d 'Import history for the current shell'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "zsh" -d 'Import history from the zsh history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "zsh-hist-db" -d 'Import history from the zsh history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "bash" -d 'Import history from the bash history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "replxx" -d 'Import history from the replxx history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "resh" -d 'Import history from the resh history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "fish" -d 'Import history from the fish history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "nu" -d 'Import history from the nu history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "nu-hist-db" -d 'Import history from the nu history file'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "xonsh" -d 'Import history from xonsh json files'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from import" -f -a "xonsh-sqlite" -d 'Import history from xonsh sqlite db'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from account" -f -a "login" -d 'Login to the configured server'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from account" -f -a "register" -d 'Register a new account'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from account" -f -a "logout" -d 'Log out'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from account" -f -a "delete" -d 'Delete your account, and all synced data'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from account" -f -a "change-password" -d 'Change your password'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from account" -f -a "verify" -d 'Verify your account'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from kv" -f -a "set"
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from kv" -f -a "get"
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from kv" -f -a "list"
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from store" -f -a "status" -d 'Print the current status of the record store'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from store" -f -a "rebuild" -d 'Rebuild a store (eg atuin store rebuild history)'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from store" -f -a "rekey" -d 'Re-encrypt the store with a new key (potential for data loss!)'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from store" -f -a "purge" -d 'Delete all records in the store that cannot be decrypted with the current key'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from store" -f -a "verify" -d 'Verify that all records in the store can be decrypted with the current key'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from store" -f -a "push" -d 'Push all records to the remote sync server (one way sync)'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from store" -f -a "pull" -d 'Pull records from the remote sync server (one way sync)'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from dotfiles" -f -a "alias" -d 'Manage shell aliases with Atuin'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from dotfiles" -f -a "var" -d 'Manage shell and environment variables with Atuin'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from server" -f -a "start" -d 'Start the server'
complete -c atuin -n "__fish_atuin_using_subcommand help; and __fish_seen_subcommand_from server" -f -a "default-config" -d 'Print server example configuration'
