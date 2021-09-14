local BaseUI = {}
function BaseUI:ctor() end

function BaseUI:getResPath() end

function BaseUI:onLoadComplete() end

function BaseUI:onRefresh() end

function BaseUI:onClose() end

function BaseUI:onInitEvent() end

function BaseUI:registerEvent(eventType,func)
    if(self.eventList[eventType] == nil)then
        local a={}
        table.insert(a,func)
        self.eventList[eventType] = a
    else
        table.insert(self.eventList[eventType],func)
    end
    EventSystem:addListener(eventType, func)
end

function BaseUI:removeEvent(eventType)
    for i,v in pairs(self.eventList[eventType]) do
        EventSystem:removeListener(eventType, v)
        table.remove(self.eventList[eventType],i)
    end
end

function BaseUI:startLoad(index)
    local path = self:getResPath()
    UIManager:loadGameObject(path, function(gameObject)
        self.gameObject = gameObject
        if self.uiNode == "normal" then
            self.gameObject.transform:SetParent(UIManager.normal.transform, false)
        elseif self.uiNode == "popup" then
            self.gameObject.transform:SetParent(UIManager.popup.transform, false)
            UIManager.mask.gameObject:SetActive(true)
            UIManager.uiTransform[index] = UIManager.mask
            self:setUIOrder(index)
        end
        index = index +1
        self.index = index
        UIManager.uiTransform[index] = gameObject.transform
        self.uiTransform = gameObject.transform
        self:setUIOrder(index)
        self:onLoadComplete()
        self:onInitEvent()
        self:onRefresh()
    end)
end

function BaseUI:show(index)
    if self.uiNode == "popup" then
        UIManager.mask.gameObject:SetActive(true)
        UIManager.uiTransform[index] = UIManager.mask
        self:setUIOrder(index)
    end

    UIManager.uiTransform[self.index] = nil
    index = index +1
    self.index = index
    UIManager.uiTransform[index] = self.uiTransform
    self:setUIOrder(index)

    if not self.gameObject.activeSelf then
        self.uiTransform.gameObject:SetActive(true)
        self:onInitEvent()
        self:onRefresh()
    end
end

function BaseUI:setUIOrder(index)
    for i, v in pairs(UIManager.uiTransform) do
        if i >= index then
            v:SetSiblingIndex(i)
        end
    end
end

function BaseUI:closeUI(uiName)
    UIManager:closeUI(uiName)
    self:onClose()
end

function BaseUI:hide()
    self.uiTransform.gameObject:SetActive(false)
end

function BaseUI:delete()
    CS.UnityEngine.GameObject.Destroy(self.uiTransform.gameObject)
end

return BaseUI