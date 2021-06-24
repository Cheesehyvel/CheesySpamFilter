local _chatWindowsCount = 0

local function chatWindowsCount()
    if _chatWindowsCount ~= 0 then
        return _chatWindowsCount
    end

    local name = nil

    for i=1,30
    do
        name = GetChatWindowInfo(i)
        if name == nil then
            return i-1;
        end
    end

    return 30
end


local lastMsg = ""
local lastCount = 0

local function chatMessageFilter (self, event, message, from, t1, t2, t3, t4, t5, chnum, chname, ...)
    if (from ~= nil) and (from ~= "") then

        if lastMsg == message then
            lastCount = lastCount + 1
            if lastCount >= chatWindowsCount() then
                return true
            end
        else
            lastCount = 0
        end

        lastMsg = message
    end
end

local chatEvents = (
        {
        "CHAT_MSG_CHANNEL",
        }
    )

for key, value in pairs (chatEvents) do
    ChatFrame_AddMessageEventFilter(value, chatMessageFilter)
end