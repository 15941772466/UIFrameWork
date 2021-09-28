local BagManager = require "module/bag/bag_manager"
local BagUI = class("BagUI", BaseUI)

local MIN_CELL_COUNT = 20
local ROW_ITEM_MAX_COUNT = 4
local CELL_HEIGHT = 105
local CELL_GAP = 30

function BagUI:getNode()
    return UIConst.UI_NODE.POPUP
end

function BagUI:getResPath()
    return "Assets/res/prefabs/bag_ui.prefab"
end

function BagUI:onLoadComplete()
    BagManager:init()
    --测试：添加背包道具按钮
    self.propOneBtn = self.uiTransform:Find("prop_one"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.propOneBtn.onClick:AddListener(function() self:propOneBtnOnClick() end)
    self.propTwoBtn = self.uiTransform:Find("prop_two"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.propTwoBtn.onClick:AddListener(function() self:propTwoBtnOnClick() end)
    self.propThreeBtn = self.uiTransform:Find("prop_three"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.propThreeBtn.onClick:AddListener(function() self:propThreeBtnOnClick() end)

    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn.onClick:AddListener(function() self:backBtnOnClick() end)
    self.content = self.uiTransform:Find("bag/content"):GetComponent(typeof(CS.UnityEngine.RectTransform))
    self.emptyCellUIList = {}
    self.emptyIndex = 5000
    for _, v in ipairs (DataManager.bagData.bagItemDataList) do
        local ItemCell = require("ui/bag/item_cell"):create(v.id)
        table.insert(BagManager.ItemCellList, ItemCell)
        ItemCell:startLoad(v.id)
    end
end

function BagUI:onRefresh()
    for i, v in ipairs (BagManager.ItemCellList) do
        v:onRefresh()
    end
    self.bagItemListCount = #DataManager.bagData.bagItemDataList
    self.nowItemListCount = #self.emptyCellUIList + self.bagItemListCount
    if self.bagItemListCount < MIN_CELL_COUNT then
        if self.nowItemListCount < MIN_CELL_COUNT then
            for i = 1, MIN_CELL_COUNT - self.nowItemListCount do
                self:addEmptyCell()
            end
        elseif self.nowItemListCount > MIN_CELL_COUNT then
            for i = #self.emptyCellUIList, 1 ,-1 do
                self:delEmptyCell(i)
                if #self.emptyCellUIList + self.bagItemListCount - MIN_CELL_COUNT == 0 then
                    self:refreshContentSize()
                    return
                end
            end
        end
    else
        local needCellCount = ROW_ITEM_MAX_COUNT - self.nowItemListCount % ROW_ITEM_MAX_COUNT

        --需要补一整行时
        if needCellCount == ROW_ITEM_MAX_COUNT then
            --数据不变、再次刷新时跳过补全
            if #self.emptyCellUIList ~= 0 then
                return
            end
        end
        for i = 1, needCellCount do
            self:addEmptyCell()
        end
        --检查并删除多余空背包行
        if #self.emptyCellUIList > ROW_ITEM_MAX_COUNT then
            for i = ROW_ITEM_MAX_COUNT, 1 ,-1 do
                self:delEmptyCell(i)
            end
        end
    end
    self:refreshContentSize()
end

function BagUI:addEmptyCell()
    self.emptyIndex = self.emptyIndex + 1
    local emptyCellUI = require("ui/bag/item_cell"):create()
    table.insert(self.emptyCellUIList, emptyCellUI)
    emptyCellUI:startLoad(self.emptyIndex)
end

function BagUI:delEmptyCell(i)
    --删除多余空白cell（已加载完毕 or 正在加载中）
    if self.emptyCellUIList[i].index then
        CS.UnityEngine.GameObject.Destroy(BagManager.cellTransformMap[self.emptyCellUIList[i].index - 1].gameObject)
        BagManager.cellTransformMap[self.emptyCellUIList[i].index - 1] = nil
    else
        self.emptyCellUIList[i].deleted = true
    end

    table.remove(self.emptyCellUIList, i)
end

function BagUI:refreshContentSize()
    local contentHeight =  (CELL_HEIGHT + CELL_GAP) * (#self.emptyCellUIList + self.bagItemListCount)/4
    self.content.sizeDelta = {x = 0, y = contentHeight}
end

function BagUI:onCover()
end

function BagUI:onReShow()
    for _, v in ipairs (BagManager.ItemCellList) do
        v:onRefresh()
    end
    self:onRefresh()
end

function BagUI:onInitEvent()
end

function BagUI:backBtnOnClick()
    self:closeUI()
end

function BagUI:propOneBtnOnClick()
    local propOne = DataManager.bagData.bagItemDataMap[50]
    if propOne and propOne.num > 0 then
        propOne.num  = propOne.num + 1
        DataManager.data.bag[50] = propOne.num
    else
        DataManager.data.bag[50] = 1
        local item = require("data/bag/item_entity"):create(50, 1)
        table.insert(DataManager.bagData.bagItemDataList, item)
        DataManager.bagData.bagItemDataMap[50] = item
        local ItemCell = require("ui/bag/item_cell"):create(50)
        table.insert(BagManager.ItemCellList, ItemCell)
        ItemCell:startLoad(50)
    end
    self:onRefresh()
end

function BagUI:propTwoBtnOnClick()
    local propOne = DataManager.bagData.bagItemDataMap[26]
    if propOne and propOne.num > 0 then
        propOne.num  = propOne.num + 1
        DataManager.data.bag[26] = propOne.num
    else
        DataManager.data.bag[26] = 1
        local item = require("data/bag/item_entity"):create(26, 1)
        table.insert(DataManager.bagData.bagItemDataList, item)
        DataManager.bagData.bagItemDataMap[26] = item
        local ItemCell = require("ui/bag/item_cell"):create(26)
        table.insert(BagManager.ItemCellList, ItemCell)
        ItemCell:startLoad(26)
    end
    self:onRefresh()
end

function BagUI:propThreeBtnOnClick()

end

function BagUI:onClose()
end

return BagUI


