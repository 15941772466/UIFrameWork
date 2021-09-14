local BagUI = class("BagUI", BaseUI)
BagUI.uiName = "bagUI"
BagUI.uiNode = "popup"
BagUI.resPath = "Assets/res/prefabs/bag_ui.prefab"
BagUI.eventList = {}

function BagUI:onLoadComplete()
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn.onClick:AddListener(self.backBtnOnClick)
end

function BagUI:onRefresh()
    --刷新
end

function BagUI:onClose()
    self:removeEvent(UIConst.eventType.BAG_BACK_EVENT)
end

function BagUI:onInitEvent()
    self:registerEvent(UIConst.eventType.BAG_BACK_EVENT, self.bagBackEvent)
end

function BagUI:getResPath()
    return self.resPath
end

function BagUI:backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_BACK_EVENT)
end

function BagUI:bagBackEvent()
    BagUI:closeUI("bagUI")
end

return BagUI