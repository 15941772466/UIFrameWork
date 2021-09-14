local EventSystem = {}

function EventSystem:addListener(eventType,func)
    if(eventType == nil)then
        Logger.log('在EventSystem:addListener中eventType为空')
        return
    end
    if(func == nil)then
        Logger.log('在EventSystem:addListener中func为空')
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
    if(eventType == nil)then
        Logger.log('在EventSystem:removeListener中eventType为空')
        return
    end
    if(func == nil)then
        Logger.log('在EventSystem:removeListener中func为空')
        return
    end
    local a = EventSystem[eventType]
    if(a ~= nil)then
        for k,v in pairs(a) do
            if(v == func)then
                a[k] = nil
                --Logger.log('EventSystem:removeListener 成功')
            end
        end
    end
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