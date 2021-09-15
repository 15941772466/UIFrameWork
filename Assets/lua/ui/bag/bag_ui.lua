local BagUI = class("BagUI", BaseUI)

function BagUI:getNode()
    return UIConst.UI_NODE.POPUP
end

function BagUI:getResPath()
    return "Assets/res/prefabs/bag_ui.prefab"
end

function BagUI:onLoadComplete()
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn.onClick:AddListener(self.backBtnOnClick)
end

function BagUI:onRefresh()
end

function BagUI:onClose()
end

function BagUI:onCover()
end

function BagUI:onInitEvent()
    self:registerEvent(UIConst.EVENT_TYPE.BAG_BACK_EVENT, function() self:bagBackEvent() end)
end

function BagUI:backBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.BAG_BACK_EVENT)
end

function BagUI:bagBackEvent()
    self:closeUI()
end

return BagUI