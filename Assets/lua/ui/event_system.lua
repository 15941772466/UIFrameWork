local EventSystem = {}

function EventSystem:addListener(eventType,func)
    if(eventType == nil or func == nil)then
        Logger.log('在EventSystem:addListener中eventType或func为空')
        return
    end
    if(EventSystem[eventType] == nil)then
        local a={}
        table.insert(a,func)
        EventSystem[eventType] = a
    else
        table.insert(EventSystem[eventType],func)
    end
end

function EventSystem:removeListener(eventType,func)
    if(eventType == nil or func == nil)then
        Logger.log('在EventSystem:removeListener中eventType或func为空')
        return
    end
    local a = EventSystem[eventType]
    if(a ~= nil)then
        Logger.log(eventType)
        for k,v in pairs(a) do
            if(v == func)then
                Logger.log(v)
                Logger.log(func)
                a[k] = nil
                Logger.log('EventSystem:removeListener 成功')
            end
        end
    end
    Logger.log('EventSystem:removeListener 执行完')
end

function EventSystem:sendEvent(eventType,...)
    if(eventType ~= nil)then
        local a = EventSystem[eventType]
        if(a ~= nil)then
            for k,v in pairs(a) do
                v(...)
            end
        end
    end
end

return EventSystem