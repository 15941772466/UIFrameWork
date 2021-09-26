local BagManager = require "module/bag/bag_manager"
local BagUI = class("BagUI", BaseUI)

local MIN_CELL_COUNT = 20

function BagUI:getNode()
    return UIConst.UI_NODE.POPUP
end

function BagUI:getResPath()
    return "Assets/res/prefabs/bag_ui.prefab"
end

function BagUI:onLoadComplete()
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn.onClick:AddListener(function() self:backBtnOnClick() end)
    self.content = self.uiTransform:Find("bag/content"):GetComponent(typeof(CS.UnityEngine.RectTransform))
    self.content.sizeDelta = {x = 0, y = 5000}
    self.ItemCellList = {}
    self.emptyCellUIList = {}
    for _, v in pairs (DataManager.bagData.bagItemList) do
        local ItemCell = require("ui/bag/item_cell"):create(v.id)
        table.insert(self.ItemCellList, ItemCell)
        ItemCell:startLoad()
    end
end

function BagUI:onRefresh()
    for _, v in ipairs (self.ItemCellList) do
        v:onRefresh()
    end
    local bagItemListCount = #DataManager.bagData.bagItemList
    --补全背包格数
    local needCellCount = 4 - bagItemListCount % 4
    if self.emptyCellUICount ~= needCellCount then
        self.emptyCellUICount = needCellCount
        for i = 1, needCellCount do
            local emptyCellUI = require("ui/bag/item_cell"):create()
            table.insert(self.emptyCellUIList, emptyCellUI)
            emptyCellUI:startLoad()
        end
    end
    -- 不足最小背包格数时
    local nowItemListCount = #self.emptyCellUIList + bagItemListCount
    if nowItemListCount < MIN_CELL_COUNT then
        for i = 1, MIN_CELL_COUNT - nowItemListCount do
            local emptyCellUI = require("ui/bag/item_cell"):create()
            table.insert(self.emptyCellUIList, emptyCellUI)
            emptyCellUI:startLoad()
        end
    end
end

function BagUI:onCover()
end

function BagUI:onReShow()
    for _, v in ipairs (self.ItemCellList) do
        v:onRefresh()
    end
    self:onRefresh()
end

function BagUI:onInitEvent()
end

function BagUI:backBtnOnClick()
    self:closeUI()
end

function BagUI:onClose()
end

return BagUI