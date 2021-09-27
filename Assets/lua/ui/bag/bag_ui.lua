local BagManager = require "module/bag/bag_manager"
local BagUI = class("BagUI", BaseUI)

local MIN_CELL_COUNT = 20
local ROW_ITEM_MAX_COUNT = 4

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
                self:delEmptyCell(i)
                BagManager.cellTransformMap[self.emptyCellUIList[i].index - 1] = nil
                table.remove(self.emptyCellUIList, i)
                if #self.emptyCellUIList + bagItemListCount - MIN_CELL_COUNT == 0 then
                    return
                end
            end
        end
    else
        local needCellCount = ROW_ITEM_MAX_COUNT - nowItemListCount % ROW_ITEM_MAX_COUNT
        --需要补一整行时
        if needCellCount == ROW_ITEM_MAX_COUNT then
            --数据不变、再次刷新时跳过补全
            if #self.emptyCellUIList ~= 0 then
                return
            end
        end
        for i = 1, needCellCount do
            self.emptyIndex = self.emptyIndex + 1
            local emptyCellUI = require("ui/bag/item_cell"):create()
            table.insert(self.emptyCellUIList, emptyCellUI)
            emptyCellUI:startLoad(self.emptyIndex)
        end
        if #self.emptyCellUIList > ROW_ITEM_MAX_COUNT then
            for i = ROW_ITEM_MAX_COUNT, 1 ,-1 do
                self:delEmptyCell(i)
                table.remove(self.emptyCellUIList, i)
            end
        end
    end
    local height =  (105 + 30) * (#self.emptyCellUIList + bagItemListCount)/4
    self.content.sizeDelta = {x = 0, y = height}
end

function BagUI:delEmptyCell(i)
    --删除多余空白cell（已加载完毕 or 正在加载中）
    if self.emptyCellUIList[i].index then
        CS.UnityEngine.GameObject.Destroy(BagManager.cellTransformMap[self.emptyCellUIList[i].index - 1].gameObject)
    else
        self.emptyCellUIList[i].deleted = true
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

function BagUI:propOneBtnOnClick()

end

function BagUI:propTwoBtnOnClick()

end

function BagUI:propThreeBtnOnClick()

end

function BagUI:onClose()
end

return BagUI


