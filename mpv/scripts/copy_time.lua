-- Copy the video's current time to the clipboard in HH:MM:SS.xxx format.

require("mp")
local msg = require("mp.msg")
local options = require("mp.options")

local opts = {
    copy_method = "",
}
options.read_options(opts)

local function info(s)
    msg.info(s)
    mp.osd_message(s)
end

local function timestamp(duration)
    local hours = math.floor(duration / 3600)
    local minutes = math.floor(duration % 3600 / 60)
    local seconds = duration % 60
    return string.format("%02d:%02d:%06.3f", hours, minutes, seconds)
end

local function set_clipboard(text)
    if opts.copy_method == "wayland" then
        local pipe = io.popen("wl-copy", "w")
        pipe:write(text)
        pipe:close()
    elseif opts.copy_method == "xclip" then
        local pipe = io.popen("xclip -silent -in -selection clipboard", "w")
        pipe:write(text)
        pipe:close()
    elseif opts.copy_method == "pbcopy" then
        local pipe = io.popen("pbcopy", "w")
        pipe:write(text)
        pipe:close()
    elseif opts.copy_method == "powershell" then
        mp.commandv("run", "powershell", "set-clipboard", text)
    else
        info("copy_method not in wayland, xclip, pbcopy, powershell")
    end
end

local function copy_time()
    local time_pos = mp.get_property_number("time-pos")
    local time = timestamp(time_pos)

    set_clipboard(time)
    info(string.format("Copied to Clipboard: %s", time))
end

mp.add_key_binding("F1", "copy_time", copy_time)
