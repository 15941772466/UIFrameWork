local EventSystem = {}

function EventSystem:addListener(eventType, func)
    if(eventType == nil)then
        Logger.log('在EventSystem:addListener中 eventType为空')
        return
    end
    if(func == nil)then
        Logger.log('在EventSystem:addListener中 func为空')
        return
    end
    if(EventSystem[eventType] == nil)then
        local a = {}
        table.insert(a, func)
        EventSystem[eventType] = a
    else
        for k, v in pairs (EventSystem[eventType]) do
            if(v == func)then
                return
            end
        end
        table.insert(EventSystem[eventType], func)
    end
end

function EventSystem:removeListener(eventType, func)
    if(eventType == nil)then
        Logger.log('在EventSystem:removeListener中 eventType为空')
        return
    end
    if(func == nil)then
        Logger.log('在EventSystem:removeListener中 func为空')
        return
    end
    local a = EventSystem[eventType]
    if(a ~= nil)then
        for k, v in pairs (a) do
            if(v == func)then
                a[k] = nil
            end
        end
    end
end

function EventSystem:sendEvent(eventType, ...)
    if(eventType ~= nil) then
        local a = EventSystem[eventType]
        if(a ~= nil)then
            for _, v in pairs (a) do
                v(...)
            end
        end
    end
end

--添加观察者
function EventSystem:addObserver(event,observer)
    if EventSystem[event]==nil then
        EventSystem[event] = {}
    end
    table.insert(EventSystem[event],observer)
end

--删除观察者
function EventSystem:removeObserver(event,observer)
    local item = EventSystem[event]
    if item~=nil then
        for k,v in pairs(item) do
            if v==observer then
                table.remove(item,k)
                break
            end
        end
    end
end

--触发一个事件
function EventSystem:observerPostEvent(event,...)
    local item = EventSystem[event]
    if item~=nil then
        for _,v in pairs(item) do
            v(...)
        end
    end
end

return EventSystem