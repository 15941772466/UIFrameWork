local BaseUI = {}
function BaseUI:ctor() end

function BaseUI:registerEvent() end

function BaseUI:removeEvent() end

function BaseUI:getResPath() end

function BaseUI:onLoadComplete() end

function BaseUI:onRefresh() end

function BaseUI:onClose() end

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
        self:onRefresh()
    end)
end

function BaseUI:show(index)
    UIManager.uiTransform[self.index] = nil
    self.uiTransform.gameObject:SetActive(true)
    if self.uiNode == "popup" then
        Logger.log("popup")
        UIManager.mask.gameObject:SetActive(true)
        UIManager.uiTransform[index] = UIManager.mask
        self:setUIOrder(index)
    end
    UIManager.uiTransform[index+1] = self.uiTransform
    self:setUIOrder(index+1)
    self:onRefresh()
end

function BaseUI:setUIOrder(index)
    for i, v in pairs(UIManager.uiTransform) do
        if i < index then
        else
            v:SetSiblingIndex(i)
        end
    end
end

function BaseUI:closeUI(uiName)
    UIManager:closeUI(uiName)
    Logger.logWarning("BaseUI:closeUI")
    self:onClose()
end

function BaseUI:hide()
    self.uiTransform.gameObject:SetActive(false)
end

function BaseUI:delete()
    CS.UnityEngine.GameObject.Destroy(self.uiTransform.gameObject)
end

return BaseUI