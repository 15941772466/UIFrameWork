local ItemCellUI = class("ItemCellUI", BaseUI)

function ItemCellUI:getNode()
    return UIConst.UI_NODE.BAG
end

function ItemCellUI:getResPath()
    return "Assets/res/prefabs/item_cell_ui.prefab"
end

function ItemCellUI:onLoadComplete()
    self.selfBtn = self.uiTransform:GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.selfBtn.onClick:AddListener(self.selfBtnOnClick)
    self.number = self.uiTransform:Find("number"):GetComponent(typeof(CS.UnityEngine.UI.Text))
    self.number.text = " "
end

function ItemCellUI:onRefresh()
    Logger.log("ItemCellUI  刷新")
end

function ItemCellUI:onClose()
    Logger.log("ItemCellUI  关闭")
end

function ItemCellUI:onCover()
    Logger.log("ItemCellUI  被覆盖")
end

function ItemCellUI:onReShow()
    Logger.log("ItemCellUI  被重新打开 ")
end

function ItemCellUI:onInitEvent()
    self:registerEvent(UIConst.EVENT_TYPE.ITEM_CLICK_EVENT, function() self:onClickEvent() end)
end

function ItemCellUI:selfBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.ITEM_CLICK_EVENT)
end

function ItemCellUI:onClickEvent()
    UIManager:openUI(UIConst.UI_TYPE.PROP_DETAIL_UI)
end

return ItemCellUI