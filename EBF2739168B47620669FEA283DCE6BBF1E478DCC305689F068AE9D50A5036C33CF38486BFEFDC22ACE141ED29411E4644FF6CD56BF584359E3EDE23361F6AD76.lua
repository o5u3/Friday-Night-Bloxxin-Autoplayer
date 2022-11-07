if _G.LegacyUI == true then
-- Legacy UI Version --
loadstring(game:HttpGet("https://raw.githubusercontent.com/o5u3/Friday-Night-Bloxxin-Autoplayer/main/A877C871B0D7D819244A6EB23BEEF99546267BE2866F4CEF43394965A6D073E7D85884C036E25C666776D3D112D4636EFC44550D849C20586EE278CD9C2B6B61.lua"))()
else
-- New UI Version --
loadstring(game:HttpGet("https://raw.githubusercontent.com/o5u3/Friday-Night-Bloxxin-Autoplayer/main/1E8060DC853AF9CFAFA7D85521C6E748C8C9FEFEB69899F3A70D9D7A049AC31B80620298140FEA82AB514FA6CEF2863D9423E7217CF8791BDE68BCFF5785B37E.lua"))()
end

game.StarterGui:SetCore("SendNotification", {Title = "DISCONTINUED", Text = "FYI: This is patched but Open-Source.", Duration = 4,})
