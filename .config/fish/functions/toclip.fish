function toclip --description="Copy last command to clipboard"
    atuin history last | string match -rq '^\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s+(?<command>.*)\s+\d+ms'
    wl-copy "$command"
end

