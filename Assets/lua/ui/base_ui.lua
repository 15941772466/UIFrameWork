local BaseUI = {}

function BaseUI:ctor() end

function BaseUI:getResPath() end

function BaseUI:onLoadComplete() end

function BaseUI:onRefresh() end

function BaseUI:onClose() end

function BaseUI:onInitEvent() end

function BaseUI:onCover() end

function BaseUI:onReShow() end

function BaseUI:registerEvent(eventType, func)
    for _, v in ipairs (self.eventTypeList) do
        if v == eventType then
            table.insert(self.eventMap[eventType], func)
            EventSystem:addListener(eventType, func)
            return
        end
    end
    table.insert(self.eventTypeList, eventType)
    local a = {}
    table.insert(a, func)
    self.eventMap[eventType] = a
    EventSystem:addListener(eventType, func)
end

function BaseUI:removeEvent(eventType)
    if self.eventMap then
        self.eventMap = {}
    end
    for _, v in pairs (self.eventMap[eventType]) do
        EventSystem:removeListener(eventType, v)
    end
    self.eventMap[eventType] = {}
end

function BaseUI:removeAllEvents()
    if not self.eventMap then
        self.eventMap = {}
    end
    if not self.eventTypeList then
        self.eventTypeList = {}
    end
    for _, eventType in ipairs (self.eventTypeList) do
        for _, v in pairs (self.eventMap[eventType]) do
            EventSystem:removeListener(eventType, v)
        end
        self.eventMap[eventType] = {}
    end
end

function BaseUI:startLoad(index)
    local path = self:getResPath()
    UIManager:loadGameObject(path, function(gameObject)
        self.eventMap = {}
        self.eventTypeList = {}
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
        self:setUIOrder(index)
        self:topUIOnCover()
        self:onLoadComplete()
        self:onInitEvent()
        self:onRefresh()
        if self.closed then
            self:closeUI()
        end
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
    if not self.gameObject.activeSelf then
        self.uiTransform.gameObject:SetActive(true)
        self:onInitEvent()
        self:onRefresh()
    end
    self:topUIOnCover()
end

function BaseUI:setUIOrder(index)
    for i, v in pairs (UIManager.uiTransformMap) do
        if i >= index then
            v:SetSiblingIndex(i)
        end
    end
end

function BaseUI:closeUI()
    UIManager:closeUI(self)
end

function BaseUI:hide()
    self.closed = true
    if self.uiTransform then
        self:removeAllEvents()
        self:onClose()
        self:topUIOnReShow()
        self.uiTransform.gameObject:SetActive(false)
    end
end

function BaseUI:delete()
    self.closed = true
    if self.uiTransform then
        self:removeAllEvents()
        self:onClose()
        self:topUIOnReShow()
        for i, v in pairs (UIManager.uiTransformMap) do
            if self.uiTransform == v then
                UIManager.uiTransformMap[i] = nil
            end
        end
        CS.UnityEngine.GameObject.Destroy(self.uiTransform.gameObject)
    end
end

function BaseUI:topUIOnCover()
    local topIndex = 0
    local top2Index = 0
    local topUI
    local top2UI
    if #UIManager.uiList >= 2 then
        for _, v in ipairs (UIManager.uiList) do
            if v.index >= topIndex then
                topIndex = v.index
            end
        end
        for _, v in ipairs (UIManager.uiList) do
            if v.index == topIndex then
                topUI = v
            end
            break
        end

        if self == topUI then    --当外部打开自己，自己即为顶层时
            return
        end

        for _, v in ipairs (UIManager.uiList) do
            if v.index < topIndex and v.index > top2Index then
                top2Index = v.index
            end
        end
        for _, v in ipairs (UIManager.uiList) do
            if v.index == top2Index then
                top2UI = v
            end
            break
        end
        top2UI:onCover()
    end
end

function BaseUI:topUIOnReShow()
    local topIndex = 0
    local top2Index = 0
    local top2UI = 0
    if #UIManager.uiList >= 2 then
        for _, v in ipairs (UIManager.uiList) do
            if v.index >= topIndex then
                topIndex = v.index
            end
        end
        for _, v in ipairs (UIManager.uiList) do
            if v.index < topIndex and v.index > top2Index then
                top2Index = v.index
            end
        end
        for _, v in ipairs (UIManager.uiList) do
            if v.index == top2Index then
                top2UI = v
            end
            break
        end
        top2UI:onReShow()
    end
end

return BaseUI