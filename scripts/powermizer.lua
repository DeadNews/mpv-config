-- https://github.com/kevinlekiller/mpv_scripts/blob/master/powermizer/powermizer.lua

--[[
    https://github.com/kevinlekiller/mpv_scripts

    Sets "PowerMizer" in Nvidia GPUs with the proprietary driver to
    "Maximum Performance" mode while mpv is playing.
    Sets "PowerMizer" back to "Adaptive" when mpv is idle or exits.

    The script will try to automatically detect a GPU.

    You can also manually set your GPU like this: --script-opts=powermizer-gpu="[gpu:1]"
    Find your GPU with this command: nvidia-settings -q gpus
--]]

-- local test = os.execute("which nvidia-settings > /dev/null")
-- if (test == 0 or test == true) then
--     local gpu = mp.get_opt("powermizer-gpu")
--     if (gpu ~= nil) then
--         gpu = string.match(gpu, "%[gpu:%d+%]")
--     end
--     if (gpu == nil) then
--         local handle = assert(io.popen("nvidia-settings -q gpus"))
--         for line in handle:lines() do
--             gpu = string.match(line, "%[gpu:%d+%]")
--             if (gpu ~= nil) then
--                 break
--             end
--         end
--         handle:close()
--         if (gpu == nil) then
--             gpu = "[gpu:0]"
--         end
--     end

--     function switch(name, paused)
--         -- If it's nil it's because of the "shutdown" event.
--         if (paused == true or paused == nil) then
--             os.execute("nvidia-settings -a " .. gpu .. "/GPUPowerMizerMode=0 > /dev/null")
--         else
--             os.execute("nvidia-settings -a " .. gpu .. "/GPUPowerMizerMode=1 > /dev/null")
--         end
--     end

--     mp.observe_property("core-idle", "bool", switch)
--     -- "core-idle" doesn't trigger when exiting mpv, use "shutdown" to set GPU back to adaptive.
--     mp.register_event("shutdown", switch)
-- end


gpu = "[gpu:0]"
function switch(name, paused)
    -- If it's nil it's because of the "shutdown" event.
    if (paused == true or paused == nil) then
        os.execute("nvidia-settings -a " .. gpu .. "/GPUPowerMizerMode=0 > /dev/null")
    else
        os.execute("nvidia-settings -a " .. gpu .. "/GPUPowerMizerMode=1 > /dev/null")
    end
end

mp.observe_property("core-idle", "bool", switch)
-- "core-idle" doesn't trigger when exiting mpv, use "shutdown" to set GPU back to adaptive.
mp.register_event("shutdown", switch)
