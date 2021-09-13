local BagUI = class("BagUI", BaseUI)
BagUI.uiName = "bagUI"
BagUI.uiNode = "popup"
BagUI.resPath = "Assets/res/prefabs/bag_ui.prefab"

function BagUI:onLoadComplete()
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.closed = true
end

function BagUI:onRefresh()
    if self.closed then
        self.closed = false
        self.backBtn.onClick:AddListener(self.backBtnOnClick)
        EventSystem:addListener(UIConst.eventType.BAG_BACK_EVENT, self:bagBackEvent())
    end
end

function BagUI:onClose()
    EventSystem:removeListener(UIConst.eventType.BAG_BACK_EVENT, self:bagBackEvent())
    self.closed = true
end

function BagUI:bagBackEvent()
    return function()
        self:closeUI("bagUI")
    end
end

function BagUI.backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_BACK_EVENT)
end

function BagUI:getResPath()
    return self.resPath
end

return BagUI