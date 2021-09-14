local BagUI = class("BagUI", BaseUI)
BagUI.uiName = "bagUI"
BagUI.uiNode = "popup"
BagUI.resPath = "Assets/res/prefabs/bag_ui.prefab"

function BagUI:onLoadComplete()
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.opened = true
end

function BagUI:onRefresh()
    if self.opened then
        self.backBtn.onClick:AddListener(self.backBtnOnClick)
        EventSystem:addListener(UIConst.eventType.BAG_BACK_EVENT, self.bagBackEvent)
    end
end

function BagUI:onClose()
    EventSystem:removeListener(UIConst.eventType.BAG_BACK_EVENT, self.bagBackEvent)
    self.opened = false
end

function BagUI.backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_BACK_EVENT)
end

function BagUI.bagBackEvent()
    BagUI:closeUI("bagUI")
end

function BagUI:getResPath()
    return self.resPath
end

return BagUI