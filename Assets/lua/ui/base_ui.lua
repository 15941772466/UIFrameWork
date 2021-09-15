local BaseUI = {}

-- BaseUI.uiTransformMap = {}

function BaseUI:ctor() end

function BaseUI:getResPath() end

function BaseUI:onLoadComplete() end

function BaseUI:onRefresh() end

function BaseUI:onClose() end

function BaseUI:onInitEvent() end

function BaseUI:onCover() end

function BaseUI:registerEvent(eventType, func)
    table.insert(self.eventTypeList, eventType)
    if(self.eventList[eventType] == nil)then
        local a = {}
        table.insert(a, func)
        self.eventList[eventType] = a
    else
        table.insert(self.eventList[eventType], func)
    end
    EventSystem:addListener(eventType, func)
end

function BaseUI:removeEvent(eventType)
    for i, v in ipairs(self.eventList[eventType]) do
        EventSystem:removeListener(eventType, v)
        table.remove(self.eventList[eventType], i)
    end
end

function BaseUI:removeAllEvents()
    for _, v in ipairs(self.eventTypeList) do
        for i, j in ipairs(self.eventList[v]) do
            EventSystem:removeListener(v, j)
            table.remove(self.eventList[v], i)
        end
    end
end

function BaseUI:startLoad(index)
    local path = self:getResPath()
    UIManager:loadGameObject(path, function(gameObject)
        self.gameObject = gameObject
        self.uiNode = self:getNode()
        self.gameObject.transform:SetParent(UIManager.normal.transform, false)
        if  self.uiNode == UIConst.UI_NODE.POPUP then
            UIManager.mask.gameObject:SetActive(true)
            UIManager.uiTransformMap[index] = UIManager.mask
            self:setUIOrder(index)
            index = index + 1
        end
        self.index = index
        UIManager.uiTransformMap[index] = gameObject.transform
        self.uiTransform = gameObject.transform
        self.eventList = {}
        self.eventTypeList = {}
        self:setUIOrder(index)
        self:onLoadComplete()
        self:onInitEvent()
        self:onRefresh()
    end)
end

function BaseUI:show(index)
    if self:getNode() == UIConst.UI_NODE.POPUP then
        UIManager.mask.gameObject:SetActive(true)
        UIManager.uiTransformMap[index] = UIManager.mask
        self:setUIOrder(index)
        index = index + 1
    end

    UIManager.uiTransformMap[self.index] = nil
    self.index = index
    UIManager.uiTransformMap[index] = self.uiTransform
    self:setUIOrder(index)
end

function BaseUI:reShow(index)
    if self:getNode() == UIConst.UI_NODE.POPUP then
        UIManager.mask.gameObject:SetActive(true)
        UIManager.uiTransformMap[index] = UIManager.mask
        self:setUIOrder(index)
        index = index + 1
    end

    UIManager.uiTransformMap[self.index] = nil
    self.index = index
    UIManager.uiTransformMap[index] = self.uiTransform
    self:setUIOrder(index)
    self.uiTransform.gameObject:SetActive(true)
    self:onInitEvent()
    self:onRefresh()
end

function BaseUI:setUIOrder(index)
    for i, v in pairs(UIManager.uiTransformMap) do
        if i >= index then
            v:SetSiblingIndex(i)
        end
    end
end

function BaseUI:closeUI()
    UIManager:closeUI(self)
end

function BaseUI:hide()
    self.uiTransform.gameObject:SetActive(false)
end

function BaseUI:delete()
    CS.UnityEngine.GameObject.Destroy(self.uiTransform.gameObject)
end

return BaseUI