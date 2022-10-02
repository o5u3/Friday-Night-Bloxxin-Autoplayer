setclipboard([[-- Options --
_G.LegacyUI = false -- Enable if you're having execution issues
_G.apDefault = false -- Setting this to true will enable the auto-player by default on execute
_G.joinDiscord = false -- Setting this to true will make you join the discord server on execute

loadstring(game:HttpGet("https://raw.githubusercontent.com/o5u3/Friday-Night-Bloxxin-Autoplayer/main/C26201D86CAF3855DD117C3B47AA903CBB84AE1FA9E212BD04FC604B5089302D240CE9BDF0761C9A39A678D655DCC45E53055190FF0DA149EFA52D406AF5749E.lua"))()
]])

game.StarterGui:SetCore("SendNotification", {Title = "Notification", Text = "New script copied.", Duration = 4,})
