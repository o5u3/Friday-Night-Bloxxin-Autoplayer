setclipboard([[-- Options --
_G.apDefault = false -- Setting this to true will enable the auto-player by default on execute
_G.joinDiscord = false -- Setting this to true will make you join the discord server on execute

loadstring(game:HttpGet("https://raw.githubusercontent.com/o5u3/Friday-Night-Bloxxin-Autoplayer/main/B96625273F7301ABBF0325835CD829222CAE6F1D9BCD1889862E728B7521859CE2C50C78842D718D85A2F4F56F6D08CFB2F6CFA5B7587F76F0E9078148E05062.lua"))()
]])

game.StarterGui:SetCore("SendNotification", {Title = "Notification", Text = "New script copied.", Duration = 4,})
