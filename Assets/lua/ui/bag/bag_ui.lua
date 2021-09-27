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
    BagManager:init()
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn.onClick:AddListener(function() self:backBtnOnClick() end)
    self.content = self.uiTransform:Find("bag/content"):GetComponent(typeof(CS.UnityEngine.RectTransform))
    self.content.sizeDelta = {x = 0, y = 5000}
    self.ItemCellList = {}
    self.emptyCellUIList = {}
    self.emptyIndex = 5000
    for _, v in ipairs (DataManager.bagData.bagItemList) do
        local ItemCell = require("ui/bag/item_cell"):create(v.id)
        table.insert(self.ItemCellList, ItemCell)
        ItemCell:startLoad(v.id)
    end
end

function BagUI:onRefresh()
    for _, v in ipairs (self.ItemCellList) do
        v:onRefresh()
    end

    local bagItemListCount = #DataManager.bagData.bagItemList
    local nowItemListCount = #self.emptyCellUIList + bagItemListCount

    if bagItemListCount < MIN_CELL_COUNT then
        if nowItemListCount < MIN_CELL_COUNT then
            for i = 1, MIN_CELL_COUNT - nowItemListCount do
                self.emptyIndex = self.emptyIndex + 1
                local emptyCellUI = require("ui/bag/item_cell"):create()
                table.insert(self.emptyCellUIList, emptyCellUI)
                emptyCellUI:startLoad(self.emptyIndex)
            end
        elseif nowItemListCount > MIN_CELL_COUNT then
            for i = #self.emptyCellUIList, 1 ,-1 do
                if self.emptyCellUIList[i].index then
                    CS.UnityEngine.GameObject.Destroy(BagManager.cellTransformMap[self.emptyCellUIList[i].index - 1].gameObject)
                else
                    self.emptyCellUIList[i].deleted = true
                end
                BagManager.cellTransformMap[self.emptyCellUIList[i].index - 1] = nil
                table.remove(self.emptyCellUIList, i)
                if #self.emptyCellUIList + bagItemListCount - MIN_CELL_COUNT == 0 then
                    return
                end
            end
        end
    else
        local needCellCount = 4 - nowItemListCount % 4
        Logger.log(needCellCount)
        if needCellCount == 4 then
            if #self.emptyCellUIList ~= 0 then   --重新刷新时跳过补全 以及 限制补一行
                return
            end
        end
        for i = 1, needCellCount do
            self.emptyIndex = self.emptyIndex + 1
            local emptyCellUI = require("ui/bag/item_cell"):create()
            table.insert(self.emptyCellUIList, emptyCellUI)
            emptyCellUI:startLoad(self.emptyIndex)
        end
        if #self.emptyCellUIList > 4 then
            for i = 4, 1 ,-1 do
                if self.emptyCellUIList[i].index then
                    CS.UnityEngine.GameObject.Destroy(BagManager.cellTransformMap[self.emptyCellUIList[i].index - 1].gameObject)
                else
                    self.emptyCellUIList[i].deleted = true
                end
                table.remove(self.emptyCellUIList, i)
            end
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


