local function file_exists(filename)
    local f = io.open(filename, "r")
    if f~=nil then io.close(f) return true else return false end
end

local function info(content)
    return ya.notify {
        title = "Convert",
        content = content,
        timeout = 5,
    }
end

local function has_value(val)
    local tab = { ".jpg", ".png", ".webp" }
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local selected_or_hovered = ya.sync(function()
    local tab, paths = cx.active, {}
    for _, u in pairs(tab.selected) do
        paths[#paths + 1] = tostring(u)
    end
    if #paths == 0 and tab.current.hovered then
        paths[1] = tostring(tab.current.hovered.url)
    end
    return paths
end)

return {
    entry = function(self, job)
        local destination_extension = job.args.extension
        if destination_extension == nil then
            destination_extension = '.jpg'
        elseif string.sub(destination_extension, 1, 1) ~= "." then
            destination_extension = "." .. destination_extension
        end
        local urls = selected_or_hovered()
        for _, source in pairs(urls) do
            local source_extension = source:match("^.+(%..+)$")
            if source_extension ~= destination_extension and has_value(source_extension) then
                local destination = string.gsub(source, source_extension, destination_extension)
                if file_exists(destination) then
                    local message = string.format("File %s already exists", destination)
                    info(message)
                    return
                end
                local output, err = Command("magick"):arg(tostring(source)):arg(tostring(destination)):output()
                local message = ""
                if not output or err then
                    message = string.format("Failed to convert from %s to %s. %s", source, destination, err)
                elseif output.stdout == "" then
                    message = string.format("Converted %s to %s", source, destination)
                end
                info(message)
            end
        end
    end,
}
