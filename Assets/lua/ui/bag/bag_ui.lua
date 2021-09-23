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
    UIManager:openUI(UIConst.UI_TYPE.ITEM_CELL_UI)
    for i, v in pairs (BagController:getItems()) do

    end
end

function BagUI:onRefresh()

end

function BagUI:onClose()
    Logger.log("BagUI  关闭 ")
end

function BagUI:onCover()
    Logger.log("BagUI  被覆盖 ")
end

function BagUI:onReShow()
    Logger.log("BagUI  被重新打开 ")
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