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
    self.content = self.uiTransform:Find("bag/content"):GetComponent(typeof(CS.UnityEngine.RectTransform))
    self.content.sizeDelta = {x = 0, y = 5000}
    BagUI.itemCellUIList = {}
    BagUI.emptyCellUIList = {}
    for _, v in pairs (BagManager:getBagDataList()) do
        local itemCellUI = require("ui/bag/item_cell_ui"):create(v.id)
        table.insert(self.itemCellUIList, itemCellUI)
        itemCellUI:startLoad()
    end
end

function BagUI:onRefresh()
    for _, v in ipairs (self.itemCellUIList) do
        v:onRefresh()
    end
    local needCellNum = 4 - #BagManager:getBagDataList() % 4
    if self.emptyCellUINum ~= needCellNum then
        self.emptyCellUINum = needCellNum
        for i = 1, needCellNum do
            local emptyCellUI = require("ui/bag/item_cell_ui"):create()
            table.insert(self.emptyCellUIList, emptyCellUI)
            emptyCellUI:startLoad()
        end
    end
end

function BagUI:onClose()
end

function BagUI:onCover()
end

function BagUI:onReShow()
    for _, v in ipairs (self.itemCellUIList) do
        v:onRefresh()
    end
    self:onRefresh()
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