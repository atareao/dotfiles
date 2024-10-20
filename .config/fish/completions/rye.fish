# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_rye_global_optspecs
	string join \n env-file= version h/help
end

function __fish_rye_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_rye_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_rye_using_subcommand
	set -l cmd (__fish_rye_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c rye -n "__fish_rye_needs_command" -l env-file -d 'Load one or more .env files' -r -F
complete -c rye -n "__fish_rye_needs_command" -l version -d 'Print the version'
complete -c rye -n "__fish_rye_needs_command" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_needs_command" -f -a "add" -d 'Adds a Python package to this project'
complete -c rye -n "__fish_rye_needs_command" -f -a "build" -d 'Builds a package for distribution'
complete -c rye -n "__fish_rye_needs_command" -f -a "config" -d 'Reads or modifies the global `config.toml` file'
complete -c rye -n "__fish_rye_needs_command" -f -a "fetch" -d 'Fetches a Python interpreter for the local machine'
complete -c rye -n "__fish_rye_needs_command" -f -a "fmt" -d 'Run the code formatter on the project'
complete -c rye -n "__fish_rye_needs_command" -f -a "init" -d 'Initialize a new or existing Python project with Rye'
complete -c rye -n "__fish_rye_needs_command" -f -a "install" -d 'Installs a package as global tool'
complete -c rye -n "__fish_rye_needs_command" -f -a "lock" -d 'Updates the lockfiles without installing dependencies'
complete -c rye -n "__fish_rye_needs_command" -f -a "lint" -d 'Run the linter on the project'
complete -c rye -n "__fish_rye_needs_command" -f -a "make-req" -d 'Builds and prints a PEP 508 requirement string from parts'
complete -c rye -n "__fish_rye_needs_command" -f -a "pin" -d 'Pins a Python version to this project'
complete -c rye -n "__fish_rye_needs_command" -f -a "publish" -d 'Publish packages to a package repository'
complete -c rye -n "__fish_rye_needs_command" -f -a "remove" -d 'Removes a package from this project'
complete -c rye -n "__fish_rye_needs_command" -f -a "run" -d 'Runs a command installed into this package'
complete -c rye -n "__fish_rye_needs_command" -f -a "show" -d 'Prints the current state of the project'
complete -c rye -n "__fish_rye_needs_command" -f -a "sync" -d 'Updates the virtualenv based on the pyproject.toml'
complete -c rye -n "__fish_rye_needs_command" -f -a "test" -d 'Run the tests on the project'
complete -c rye -n "__fish_rye_needs_command" -f -a "toolchain" -d 'Helper utility to manage Python toolchains'
complete -c rye -n "__fish_rye_needs_command" -f -a "tools" -d 'Helper utility to manage global tools'
complete -c rye -n "__fish_rye_needs_command" -f -a "self" -d 'Rye self management'
complete -c rye -n "__fish_rye_needs_command" -f -a "uninstall" -d 'Uninstalls a global tool'
complete -c rye -n "__fish_rye_needs_command" -f -a "version" -d 'Get or set project version'
complete -c rye -n "__fish_rye_needs_command" -f -a "list" -d 'Prints the currently installed packages'
complete -c rye -n "__fish_rye_needs_command" -f -a "shell" -d 'The shell command was removed'
complete -c rye -n "__fish_rye_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand add" -l git -d 'Install the given package from this git repository' -r
complete -c rye -n "__fish_rye_using_subcommand add" -l url -d 'Install the given package from this URL' -r
complete -c rye -n "__fish_rye_using_subcommand add" -l path -d 'Install the given package from this local path' -r -F
complete -c rye -n "__fish_rye_using_subcommand add" -l tag -d 'Install a specific tag' -r
complete -c rye -n "__fish_rye_using_subcommand add" -l rev -d 'Update to a specific git rev' -r
complete -c rye -n "__fish_rye_using_subcommand add" -l branch -d 'Update to a specific git branch' -r
complete -c rye -n "__fish_rye_using_subcommand add" -l features -d 'Adds a dependency with a specific feature' -r
complete -c rye -n "__fish_rye_using_subcommand add" -l optional -d 'Add this to an optional dependency group' -r
complete -c rye -n "__fish_rye_using_subcommand add" -l pin -d 'Overrides the pin operator' -r -f -a "{equal\t'',tilde-equal\t'',greater-than-equal\t''}"
complete -c rye -n "__fish_rye_using_subcommand add" -l keyring-provider -d 'Attempt to use `keyring` for authentication for index URLs' -r -f -a "{disabled\t'Do not use keyring for credential lookup',subprocess\t'Use the `keyring` command for credential lookup'}"
complete -c rye -n "__fish_rye_using_subcommand add" -l absolute -d 'Force non interpolated absolute paths'
complete -c rye -n "__fish_rye_using_subcommand add" -s d -l dev -d 'Add this as dev dependency'
complete -c rye -n "__fish_rye_using_subcommand add" -l excluded -d 'Add this as an excluded dependency that will not be installed even if it\'s a sub dependency'
complete -c rye -n "__fish_rye_using_subcommand add" -l sync -d 'Runs `sync` even if auto-sync is disabled'
complete -c rye -n "__fish_rye_using_subcommand add" -l no-sync -d 'Does not run `sync` even if auto-sync is enabled'
complete -c rye -n "__fish_rye_using_subcommand add" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand add" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand add" -l pre -d 'Include pre-releases when finding a package version and automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand add" -l with-sources -d 'Set to `true` to lock with sources in the lockfile when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand add" -l generate-hashes -d 'Set to `true` to lock with hashes in the lockfile when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand add" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand build" -s p -l package -d 'Build a specific package' -r
complete -c rye -n "__fish_rye_using_subcommand build" -s o -l out -d 'An output directory (defaults to `workspace/dist`)' -r -F
complete -c rye -n "__fish_rye_using_subcommand build" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand build" -l sdist -d 'Build a sdist'
complete -c rye -n "__fish_rye_using_subcommand build" -l wheel -d 'Build a wheel'
complete -c rye -n "__fish_rye_using_subcommand build" -s a -l all -d 'Build all packages'
complete -c rye -n "__fish_rye_using_subcommand build" -s c -l clean -d 'Clean the output directory first'
complete -c rye -n "__fish_rye_using_subcommand build" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand build" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand build" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand config" -l format -d 'Request parseable output format rather than lines' -r -f -a "{json\t''}"
complete -c rye -n "__fish_rye_using_subcommand config" -l get -d 'Reads a config key' -r
complete -c rye -n "__fish_rye_using_subcommand config" -l set -d 'Sets a config key to a string' -r
complete -c rye -n "__fish_rye_using_subcommand config" -l set-int -d 'Sets a config key to an integer' -r
complete -c rye -n "__fish_rye_using_subcommand config" -l set-bool -d 'Sets a config key to a bool' -r
complete -c rye -n "__fish_rye_using_subcommand config" -l unset -d 'Remove a config key' -r
complete -c rye -n "__fish_rye_using_subcommand config" -l show-path -d 'Print the path to the config'
complete -c rye -n "__fish_rye_using_subcommand config" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand fetch" -l target-path -d 'Fetches the Python toolchain into an explicit location rather' -r -F
complete -c rye -n "__fish_rye_using_subcommand fetch" -s f -l force -d 'Fetch the Python toolchain even if it is already installed'
complete -c rye -n "__fish_rye_using_subcommand fetch" -l build-info -d 'Fetches with build info'
complete -c rye -n "__fish_rye_using_subcommand fetch" -l no-build-info -d 'Fetches without build info'
complete -c rye -n "__fish_rye_using_subcommand fetch" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand fetch" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand fetch" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand fmt" -s p -l package -d 'Perform the operation on a specific package' -r
complete -c rye -n "__fish_rye_using_subcommand fmt" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand fmt" -s a -l all -d 'Perform the operation on all packages'
complete -c rye -n "__fish_rye_using_subcommand fmt" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand fmt" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand fmt" -l check -d 'Run format in check mode'
complete -c rye -n "__fish_rye_using_subcommand fmt" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand init" -l min-py -d 'Minimal Python version supported by this project' -r
complete -c rye -n "__fish_rye_using_subcommand init" -s p -l py -d 'Python version to use for the virtualenv' -r
complete -c rye -n "__fish_rye_using_subcommand init" -l build-system -d 'Which build system should be used (defaults to hatchling)?' -r -f -a "{hatchling\t'',setuptools\t'',flit\t'',pdm\t'',maturin\t''}"
complete -c rye -n "__fish_rye_using_subcommand init" -l license -d 'Which license should be used (SPDX identifier)?' -r
complete -c rye -n "__fish_rye_using_subcommand init" -l name -d 'The name of the package' -r
complete -c rye -n "__fish_rye_using_subcommand init" -s r -l requirements -d 'Requirements files to initialize pyproject.toml with' -r -F
complete -c rye -n "__fish_rye_using_subcommand init" -l dev-requirements -d 'Development requirements files to initialize pyproject.toml with' -r -F
complete -c rye -n "__fish_rye_using_subcommand init" -l lib -d 'Generate a library project (default)'
complete -c rye -n "__fish_rye_using_subcommand init" -l script -d 'Generate an executable project'
complete -c rye -n "__fish_rye_using_subcommand init" -l no-readme -d 'Do not create a readme'
complete -c rye -n "__fish_rye_using_subcommand init" -l no-pin -d 'Do not create .python-version file (requires-python will be used)'
complete -c rye -n "__fish_rye_using_subcommand init" -l private -d 'Set "Private :: Do Not Upload" classifier, used for private projects'
complete -c rye -n "__fish_rye_using_subcommand init" -l no-import -d 'Don\'t import from setup.cfg, setup.py, or requirements files'
complete -c rye -n "__fish_rye_using_subcommand init" -l virtual -d 'Initialize this as a virtual package'
complete -c rye -n "__fish_rye_using_subcommand init" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand init" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand install" -l git -d 'Install the given package from this git repository' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l url -d 'Install the given package from this URL' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l path -d 'Install the given package from this local path' -r -F
complete -c rye -n "__fish_rye_using_subcommand install" -l tag -d 'Install a specific tag' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l rev -d 'Update to a specific git rev' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l branch -d 'Update to a specific git branch' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l features -d 'Adds a dependency with a specific feature' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l include-dep -d 'Include scripts from a given dependency' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l extra-requirement -d 'Additional dependencies to install that are not declared by the main package' -r
complete -c rye -n "__fish_rye_using_subcommand install" -s p -l python -d 'Optionally the Python version to use' -r
complete -c rye -n "__fish_rye_using_subcommand install" -l keyring-provider -d 'Attempt to use `keyring` for authentication for index URLs' -r -f -a "{disabled\t'Do not use keyring for credential lookup',subprocess\t'Use the `keyring` command for credential lookup'}"
complete -c rye -n "__fish_rye_using_subcommand install" -l absolute -d 'Force non interpolated absolute paths'
complete -c rye -n "__fish_rye_using_subcommand install" -s f -l force -d 'Force install the package even if it\'s already there'
complete -c rye -n "__fish_rye_using_subcommand install" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand install" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand lock" -l update -d 'Update a specific package' -r
complete -c rye -n "__fish_rye_using_subcommand lock" -l features -d 'Extras/features to enable when locking the workspace' -r
complete -c rye -n "__fish_rye_using_subcommand lock" -l keyring-provider -d 'Attempt to use `keyring` for authentication for index URLs' -r -f -a "{disabled\t'Do not use keyring for credential lookup',subprocess\t'Use the `keyring` command for credential lookup'}"
complete -c rye -n "__fish_rye_using_subcommand lock" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand lock" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand lock" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand lock" -l update-all -d 'Update all packages to the latest'
complete -c rye -n "__fish_rye_using_subcommand lock" -l pre -d 'Update to pre-release versions'
complete -c rye -n "__fish_rye_using_subcommand lock" -l all-features -d 'Enables all features'
complete -c rye -n "__fish_rye_using_subcommand lock" -l with-sources -d 'Set to true to lock with sources in the lockfile'
complete -c rye -n "__fish_rye_using_subcommand lock" -l generate-hashes -d 'Set to true to lock with hashes in the lockfile'
complete -c rye -n "__fish_rye_using_subcommand lock" -l universal -d 'Use universal lock files'
complete -c rye -n "__fish_rye_using_subcommand lock" -l reset -d 'Reset prior lock options'
complete -c rye -n "__fish_rye_using_subcommand lock" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand lint" -s p -l package -d 'Perform the operation on a specific package' -r
complete -c rye -n "__fish_rye_using_subcommand lint" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand lint" -s a -l all -d 'Perform the operation on all packages'
complete -c rye -n "__fish_rye_using_subcommand lint" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand lint" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand lint" -l fix -d 'Apply fixes'
complete -c rye -n "__fish_rye_using_subcommand lint" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand make-req" -l git -d 'Install the given package from this git repository' -r
complete -c rye -n "__fish_rye_using_subcommand make-req" -l url -d 'Install the given package from this URL' -r
complete -c rye -n "__fish_rye_using_subcommand make-req" -l path -d 'Install the given package from this local path' -r -F
complete -c rye -n "__fish_rye_using_subcommand make-req" -l tag -d 'Install a specific tag' -r
complete -c rye -n "__fish_rye_using_subcommand make-req" -l rev -d 'Update to a specific git rev' -r
complete -c rye -n "__fish_rye_using_subcommand make-req" -l branch -d 'Update to a specific git branch' -r
complete -c rye -n "__fish_rye_using_subcommand make-req" -l features -d 'Adds a dependency with a specific feature' -r
complete -c rye -n "__fish_rye_using_subcommand make-req" -l absolute -d 'Force non interpolated absolute paths'
complete -c rye -n "__fish_rye_using_subcommand make-req" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand pin" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand pin" -l relaxed -d 'Issue a relaxed pin'
complete -c rye -n "__fish_rye_using_subcommand pin" -l no-update-requires-python -d 'Prevent updating requires-python in the pyproject.toml'
complete -c rye -n "__fish_rye_using_subcommand pin" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand publish" -s r -l repository -d 'The repository to publish to' -r
complete -c rye -n "__fish_rye_using_subcommand publish" -l repository-url -d 'The repository url to publish to' -r
complete -c rye -n "__fish_rye_using_subcommand publish" -s u -l username -d 'The username to authenticate to the repository with' -r
complete -c rye -n "__fish_rye_using_subcommand publish" -l token -d 'An access token used for the upload' -r
complete -c rye -n "__fish_rye_using_subcommand publish" -s i -l identity -d 'GPG identity used to sign files' -r
complete -c rye -n "__fish_rye_using_subcommand publish" -l cert -d 'Path to alternate CA bundle' -r -F
complete -c rye -n "__fish_rye_using_subcommand publish" -l sign -d 'Sign files to upload using GPG'
complete -c rye -n "__fish_rye_using_subcommand publish" -l skip-existing -d 'Skip files that have already been published (only applies to repositories supporting this feature)'
complete -c rye -n "__fish_rye_using_subcommand publish" -s y -l yes -d 'Skip prompts'
complete -c rye -n "__fish_rye_using_subcommand publish" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand publish" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand publish" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand remove" -l optional -d 'Remove this from an optional dependency group' -r
complete -c rye -n "__fish_rye_using_subcommand remove" -l keyring-provider -d 'Attempt to use `keyring` for authentication for index URLs' -r -f -a "{disabled\t'Do not use keyring for credential lookup',subprocess\t'Use the `keyring` command for credential lookup'}"
complete -c rye -n "__fish_rye_using_subcommand remove" -s d -l dev -d 'Remove this from dev dependencies'
complete -c rye -n "__fish_rye_using_subcommand remove" -l sync -d 'Runs `sync` even if auto-sync is disabled'
complete -c rye -n "__fish_rye_using_subcommand remove" -l no-sync -d 'Does not run `sync` even if auto-sync is enabled'
complete -c rye -n "__fish_rye_using_subcommand remove" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand remove" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand remove" -l pre -d 'Include pre-releases when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand remove" -l with-sources -d 'Set to `true` to lock with sources in the lockfile when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand remove" -l generate-hashes -d 'Set to `true` to lock with hashes in the lockfile when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand remove" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand run" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand run" -s l -l list -d 'List all commands'
complete -c rye -n "__fish_rye_using_subcommand run" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand show" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand show" -l installed-deps -d 'Print the installed dependencies from the venv'
complete -c rye -n "__fish_rye_using_subcommand show" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand sync" -l update -d 'Update a specific package' -r
complete -c rye -n "__fish_rye_using_subcommand sync" -l features -d 'Extras/features to enable when syncing the workspace' -r
complete -c rye -n "__fish_rye_using_subcommand sync" -l keyring-provider -d 'Attempt to use `keyring` for authentication for index URLs' -r -f -a "{disabled\t'Do not use keyring for credential lookup',subprocess\t'Use the `keyring` command for credential lookup'}"
complete -c rye -n "__fish_rye_using_subcommand sync" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand sync" -s f -l force -d 'Force the environment to be re-created'
complete -c rye -n "__fish_rye_using_subcommand sync" -l no-dev -d 'Do not include dev dependencies'
complete -c rye -n "__fish_rye_using_subcommand sync" -l no-lock -d 'Do not update the lockfile'
complete -c rye -n "__fish_rye_using_subcommand sync" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand sync" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand sync" -l update-all -d 'Update all packages to the latest'
complete -c rye -n "__fish_rye_using_subcommand sync" -l pre -d 'Update to pre-release versions'
complete -c rye -n "__fish_rye_using_subcommand sync" -l all-features -d 'Enables all features'
complete -c rye -n "__fish_rye_using_subcommand sync" -l with-sources -d 'Set to true to lock with sources in the lockfile'
complete -c rye -n "__fish_rye_using_subcommand sync" -l generate-hashes -d 'Set to true to lock with hashes in the lockfile'
complete -c rye -n "__fish_rye_using_subcommand sync" -l reset -d 'Do not reuse (reset) prior lock options'
complete -c rye -n "__fish_rye_using_subcommand sync" -l universal -d 'Use universal lock files'
complete -c rye -n "__fish_rye_using_subcommand sync" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand test" -s p -l package -d 'Perform the operation on a specific package' -r
complete -c rye -n "__fish_rye_using_subcommand test" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand test" -l keyring-provider -d 'Attempt to use `keyring` for authentication for index URLs' -r -f -a "{disabled\t'Do not use keyring for credential lookup',subprocess\t'Use the `keyring` command for credential lookup'}"
complete -c rye -n "__fish_rye_using_subcommand test" -s a -l all -d 'Perform the operation on all packages'
complete -c rye -n "__fish_rye_using_subcommand test" -s s -l no-capture -d 'Disable test output capture to stdout'
complete -c rye -n "__fish_rye_using_subcommand test" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand test" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand test" -l pre -d 'Include pre-releases when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand test" -l with-sources -d 'Set to `true` to lock with sources in the lockfile when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand test" -l generate-hashes -d 'Set to `true` to lock with hashes in the lockfile when automatically syncing the workspace'
complete -c rye -n "__fish_rye_using_subcommand test" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and not __fish_seen_subcommand_from fetch list register remove help" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and not __fish_seen_subcommand_from fetch list register remove help" -f -a "fetch" -d 'Fetches a Python interpreter for the local machine'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and not __fish_seen_subcommand_from fetch list register remove help" -f -a "list" -d 'List all registered toolchains'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and not __fish_seen_subcommand_from fetch list register remove help" -f -a "register" -d 'Register a Python binary'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and not __fish_seen_subcommand_from fetch list register remove help" -f -a "remove" -d 'Removes a toolchain'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and not __fish_seen_subcommand_from fetch list register remove help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from fetch" -l target-path -d 'Fetches the Python toolchain into an explicit location rather' -r -F
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from fetch" -s f -l force -d 'Fetch the Python toolchain even if it is already installed'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from fetch" -l build-info -d 'Fetches with build info'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from fetch" -l no-build-info -d 'Fetches without build info'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from fetch" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from fetch" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from fetch" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from list" -l format -d 'Request parseable output format' -r -f -a "{json\t''}"
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from list" -l include-downloadable -d 'Also include non installed, but downloadable toolchains'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from register" -s n -l name -d 'Name of the toolchain.  If not provided a name is auto detected' -r
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from register" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from remove" -s f -l force -d 'Force removal even if the toolchain is in use'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from help" -f -a "fetch" -d 'Fetches a Python interpreter for the local machine'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all registered toolchains'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from help" -f -a "register" -d 'Register a Python binary'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from help" -f -a "remove" -d 'Removes a toolchain'
complete -c rye -n "__fish_rye_using_subcommand toolchain; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand tools; and not __fish_seen_subcommand_from install uninstall list help" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand tools; and not __fish_seen_subcommand_from install uninstall list help" -f -a "install" -d 'Installs a package as global tool'
complete -c rye -n "__fish_rye_using_subcommand tools; and not __fish_seen_subcommand_from install uninstall list help" -f -a "uninstall" -d 'Uninstalls a global tool'
complete -c rye -n "__fish_rye_using_subcommand tools; and not __fish_seen_subcommand_from install uninstall list help" -f -a "list" -d 'List all registered tools'
complete -c rye -n "__fish_rye_using_subcommand tools; and not __fish_seen_subcommand_from install uninstall list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l git -d 'Install the given package from this git repository' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l url -d 'Install the given package from this URL' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l path -d 'Install the given package from this local path' -r -F
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l tag -d 'Install a specific tag' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l rev -d 'Update to a specific git rev' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l branch -d 'Update to a specific git branch' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l features -d 'Adds a dependency with a specific feature' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l include-dep -d 'Include scripts from a given dependency' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l extra-requirement -d 'Additional dependencies to install that are not declared by the main package' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -s p -l python -d 'Optionally the Python version to use' -r
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l keyring-provider -d 'Attempt to use `keyring` for authentication for index URLs' -r -f -a "{disabled\t'Do not use keyring for credential lookup',subprocess\t'Use the `keyring` command for credential lookup'}"
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -l absolute -d 'Force non interpolated absolute paths'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -s f -l force -d 'Force install the package even if it\'s already there'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from uninstall" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from uninstall" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from uninstall" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from list" -s s -l include-scripts -d 'Show all the scripts installed by the tools'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from list" -s v -l include-version -d 'Show the version of tools'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from help" -f -a "install" -d 'Installs a package as global tool'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from help" -f -a "uninstall" -d 'Uninstalls a global tool'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all registered tools'
complete -c rye -n "__fish_rye_using_subcommand tools; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand self; and not __fish_seen_subcommand_from completion update install uninstall help" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand self; and not __fish_seen_subcommand_from completion update install uninstall help" -f -a "completion" -d 'Generates a completion script for a shell'
complete -c rye -n "__fish_rye_using_subcommand self; and not __fish_seen_subcommand_from completion update install uninstall help" -f -a "update" -d 'Performs an update of rye'
complete -c rye -n "__fish_rye_using_subcommand self; and not __fish_seen_subcommand_from completion update install uninstall help" -f -a "install" -d 'Triggers the initial installation of Rye'
complete -c rye -n "__fish_rye_using_subcommand self; and not __fish_seen_subcommand_from completion update install uninstall help" -f -a "uninstall" -d 'Uninstalls rye again'
complete -c rye -n "__fish_rye_using_subcommand self; and not __fish_seen_subcommand_from completion update install uninstall help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from completion" -s s -l shell -d 'The shell to generate a completion script for (defaults to \'bash\')' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t'',nushell\t''}"
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from completion" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from update" -l version -d 'Update to a specific version' -r
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from update" -l tag -d 'Update to a specific tag' -r
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from update" -l rev -d 'Update to a specific git rev' -r
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from update" -l branch -d 'Update to a specific git branch' -r
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from update" -l force -d 'Force reinstallation'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from install" -l toolchain -d 'Register a specific toolchain before bootstrap' -r -F
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from install" -l toolchain-version -d 'Use a specific toolchain version' -r
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from install" -s y -l yes -d 'Skip prompts'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from install" -l modify-path -d 'Always modify without asking the PATH environment variable'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from install" -l no-modify-path -d 'Do not modify the PATH environment variable'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from uninstall" -s y -l yes -d 'Skip safety check'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from uninstall" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from help" -f -a "completion" -d 'Generates a completion script for a shell'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from help" -f -a "update" -d 'Performs an update of rye'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from help" -f -a "install" -d 'Triggers the initial installation of Rye'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from help" -f -a "uninstall" -d 'Uninstalls rye again'
complete -c rye -n "__fish_rye_using_subcommand self; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand uninstall" -s v -l verbose -d 'Enables verbose diagnostics'
complete -c rye -n "__fish_rye_using_subcommand uninstall" -s q -l quiet -d 'Turns off all output'
complete -c rye -n "__fish_rye_using_subcommand uninstall" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand version" -s b -l bump -d 'The version bump to apply' -r -f -a "{major\t'',minor\t'',patch\t''}"
complete -c rye -n "__fish_rye_using_subcommand version" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand list" -l pyproject -d 'Use this pyproject.toml file' -r -F
complete -c rye -n "__fish_rye_using_subcommand list" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand shell" -s h -l help -d 'Print help'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "add" -d 'Adds a Python package to this project'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "build" -d 'Builds a package for distribution'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "config" -d 'Reads or modifies the global `config.toml` file'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "fetch" -d 'Fetches a Python interpreter for the local machine'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "fmt" -d 'Run the code formatter on the project'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "init" -d 'Initialize a new or existing Python project with Rye'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "install" -d 'Installs a package as global tool'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "lock" -d 'Updates the lockfiles without installing dependencies'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "lint" -d 'Run the linter on the project'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "make-req" -d 'Builds and prints a PEP 508 requirement string from parts'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "pin" -d 'Pins a Python version to this project'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "publish" -d 'Publish packages to a package repository'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "remove" -d 'Removes a package from this project'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "run" -d 'Runs a command installed into this package'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "show" -d 'Prints the current state of the project'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "sync" -d 'Updates the virtualenv based on the pyproject.toml'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "test" -d 'Run the tests on the project'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "toolchain" -d 'Helper utility to manage Python toolchains'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "tools" -d 'Helper utility to manage global tools'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "self" -d 'Rye self management'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "uninstall" -d 'Uninstalls a global tool'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "version" -d 'Get or set project version'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "list" -d 'Prints the currently installed packages'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "shell" -d 'The shell command was removed'
complete -c rye -n "__fish_rye_using_subcommand help; and not __fish_seen_subcommand_from add build config fetch fmt init install lock lint make-req pin publish remove run show sync test toolchain tools self uninstall version list shell help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from toolchain" -f -a "fetch" -d 'Fetches a Python interpreter for the local machine'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from toolchain" -f -a "list" -d 'List all registered toolchains'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from toolchain" -f -a "register" -d 'Register a Python binary'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from toolchain" -f -a "remove" -d 'Removes a toolchain'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from tools" -f -a "install" -d 'Installs a package as global tool'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from tools" -f -a "uninstall" -d 'Uninstalls a global tool'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from tools" -f -a "list" -d 'List all registered tools'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from self" -f -a "completion" -d 'Generates a completion script for a shell'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from self" -f -a "update" -d 'Performs an update of rye'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from self" -f -a "install" -d 'Triggers the initial installation of Rye'
complete -c rye -n "__fish_rye_using_subcommand help; and __fish_seen_subcommand_from self" -f -a "uninstall" -d 'Uninstalls rye again'
