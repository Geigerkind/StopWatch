-- Global Variables
StopWatch = {}

-- Local Variables
local Time = 0
local Timer = false

function StopWatch:Initialize()
	SLASH_SW1 = "/sw"
	SlashCmdList["SW"] = function(msg) 
		local cmd = string.lower(msg)
		if cmd == "show" then
			StopWatch:Show()
		elseif cmd == "hide" then
			StopWatch:Hide()
		elseif string.find(cmd, "scale") then
			local scale = string.sub(msg, 7)
			StopWatchFrame:SetScale(tonumber(scale))
		else
			StopWatch:SendMessage("Those commands are available:")
			StopWatch:SendMessage("- show (BSP: /sw show)")
			StopWatch:SendMessage("- hide (BSP: /sw hide)")
			StopWatch:SendMessage("- scale (BSP: /sw scale 1.5)")
		end
	end
end

function StopWatch:Start()
	if not Timer then
		Timer = true
	end
end

function StopWatch:Stop()
	if Timer then
		Timer = false
	end
end

function StopWatch:Reset()
	Timer = false
	Time = 0
	StopWatchFrame_Time:SetText(StopWatch:TimeFormat(Time))
end

function StopWatch:OnUpdate(self, elapsed)
	if Timer then
		Time = Time + elapsed
		StopWatchFrame_Time:SetText(StopWatch:TimeFormat(Time))
	end
end

function StopWatch:Show()
	StopWatchFrame:Show()
end

function StopWatch:Hide()
	StopWatchFrame:Hide()
end

function StopWatch:Scale(scale)
	StopWatchFrame:SetScale(scale)
end

function StopWatch:TimeFormat(time)
	local hour, minutes, seconds, mili = 0, 0, 0, 0
	hour = floor(time/3600)
	if hour < 10 then
		hour = "0"..hour
	end
	minutes = floor((time-floor(time/3600)*3600)/60)
	if minutes < 10 then
		minutes = "0"..minutes
	end
	seconds = floor(time-floor(time/3600)*3600-floor((time-floor(time/3600)*3600)/60)*60)
	if seconds < 10 then
		seconds = "0"..seconds
	end
	mili = floor((time-floor(time/3600)*3600-floor((time-floor(time/3600)*3600)/60)*60-floor(time-floor(time/3600)*3600-floor((time-floor(time/3600)*3600)/60)*60))*100)
	if mili < 10 then
		mili = "0"..mili
	end
	return hour..":"..minutes..":"..seconds..":"..mili	
end

function StopWatch:SendMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFF8080StopWatch|r: "..msg)
end