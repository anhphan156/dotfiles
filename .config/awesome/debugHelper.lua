local naughty = require('naughty')

debugHelper = {}

debugHelper.log = function (msg)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Debug",
        text = msg
    })
end

return debugHelper