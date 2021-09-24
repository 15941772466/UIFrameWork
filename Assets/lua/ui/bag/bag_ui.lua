local BagUI = class("BagUI", BaseUI)

local BagManager = require "module/bag/bag_manager"

function BagUI:getNode()
    return UIConst.UI_NODE.POPUP
end

function BagUI:getResPath()
    return "Assets/res/prefabs/bag_ui.prefab"
end

function BagUI:onLoadComplete()
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn.onClick:AddListener(self.backBtnOnClick)

    for _, v in pairs (BagManager:getBagDataList()) do
        local itemCellUI = require("ui/bag/item_cell_ui"):create(v.id)
        itemCellUI:startLoad()
    end
end

function BagUI:onRefresh()
    for _, v in ipairs (BagManager:getBagDataList()) do
        v:onRefresh()
    end
end

function BagUI:onClose()
    Logger.log("BagUI  关闭 ")
end

function BagUI:onCover()
    Logger.log("BagUI  被覆盖 ")
end

function BagUI:onReShow()
    for i, v in ipairs (UIManager.itemList) do
        v:onRefresh()
    end
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