local BagConst = require "data/bag/bag_const"
local BagUI = class("BagUI", BaseUI)

local MIN_CELL_COUNT = 20
local ROW_ITEM_MAX_COUNT = 4
local CELL_HEIGHT = 105
local CELL_GAP = 30
local MIN_EMPTY_CELL_INDEX = 5000

function BagUI:getNode()
    return UIConst.UI_NODE.POPUP
end

function BagUI:getResPath()
    return "Assets/res/prefabs/bag_ui.prefab"
end

function BagUI:onLoadComplete()
    self.allCellsList = {}
    self.itemCellList = {}
    self.emptyCellUIList = {}
    self.emptyIndex = MIN_EMPTY_CELL_INDEX
    self.equipmentBtn = self.uiTransform:Find("equipment_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.equipmentBtn.onClick:AddListener(function() self:equipmentBtnOnClick() end)
    self.inscriptionBtn = self.uiTransform:Find("inscription_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.inscriptionBtn.onClick:AddListener(function() self:inscriptionBtnOnClick() end)
    self.boxBtn = self.uiTransform:Find("box_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.boxBtn.onClick:AddListener(function() self:boxBtnOnClick() end)
    self.oreBtn = self.uiTransform:Find("ore_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.oreBtn.onClick:AddListener(function() self:oreBtnOnClick() end)

    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn.onClick:AddListener(function() self:backBtnOnClick() end)
    self.content = self.uiTransform:Find("bag/content"):GetComponent(typeof(CS.UnityEngine.RectTransform))
    self:changeBagDataByType()
end

function BagUI:onRefresh(params)
    if self.type ~= params.type then
        self.type = params.type
        self:clearItems()
        self:changeBagDataByType()
    end

    for i, v in ipairs (self.itemCellList) do
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
            for i = #self.emptyCellUIList, 1, -1 do
                self:delEmptyCell(1)
                if #self.emptyCellUIList + self.bagItemListCount - MIN_CELL_COUNT == 0 then
                    self:refreshContentSize()
                    return
                end
            end
        end
    else
        local needCellCount = ROW_ITEM_MAX_COUNT - self.nowItemListCount % ROW_ITEM_MAX_COUNT
        --?????????????????????
        if needCellCount == ROW_ITEM_MAX_COUNT then
            --??????????????????????????????????????????
            if #self.emptyCellUIList ~= 0 then
                return
            end
        end
        for i = 1, needCellCount do
            self:addEmptyCell()
        end
        --?????????????????????????????????
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
    local emptyCellUI = require("ui/bag/item_cell"):create(nil, self)
    table.insert(self.emptyCellUIList, emptyCellUI)
    emptyCellUI:startLoad(self.emptyIndex)
end

function BagUI:delEmptyCell(pos)
    --??????????????????cell?????????????????? or ??????????????????
    if self.emptyCellUIList[pos].index then
        for i, v in ipairs (self.emptyCellUIList) do
            if v == self.emptyCellUIList[i] then
                CS.UnityEngine.GameObject.Destroy(v.gameObject)
                break
            end
        end
        for i, v in ipairs (self.allCellsList) do
            if v.index == self.emptyCellUIList[pos].index then
                CS.UnityEngine.GameObject.Destroy(v.gameObject)
                table.remove(self.allCellsList, i)
                break
            end
        end
    else
        self.emptyCellUIList[pos].deleted = true
    end
    table.remove(self.emptyCellUIList, pos)
end

function BagUI:delCellTransform(id)
    DataManager.bagData:removeItem(id)
    for i, v in ipairs (DataManager.bagData.bagItemDataList) do
        if v.id == id then
            table.remove(DataManager.bagData.bagItemDataList,i)
        end
    end
    for i, v in ipairs (self.itemCellList) do
        if v.itemID == id then
            table.remove(self.itemCellList, i)
        end
    end
    for i, v in ipairs (self.allCellsList) do
        if v.itemID == id then
            CS.UnityEngine.GameObject.Destroy(v.gameObject)
            table.remove(self.allCellsList, i)
        end
    end
end

function BagUI:changeBagDataByType()
    if self.type == BagConst.TYPE.EQUIPMENT then
        DataManager.bagData.bagItemDataList = DataManager.bagData.bagEquipmentDataList
        DataManager.bagData.bagItemDataMap = DataManager.bagData.bagEquipmentDataMap
    elseif self.type == BagConst.TYPE.INSCRIPTION then
        DataManager.bagData.bagItemDataList = DataManager.bagData.bagInscriptionDataList
        DataManager.bagData.bagItemDataMap = DataManager.bagData.bagInscriptionDataMap
    elseif self.type == BagConst.TYPE.BOX then
        DataManager.bagData.bagItemDataList = DataManager.bagData.bagBoxDataList
        DataManager.bagData.bagItemDataMap = DataManager.bagData.bagBoxDataMap
    elseif self.type == BagConst.TYPE.ORE then
        DataManager.bagData.bagItemDataList = DataManager.bagData.bagOreDataList
        DataManager.bagData.bagItemDataMap = DataManager.bagData.bagOreDataMap
    end
    for _, v in ipairs (DataManager.bagData.bagItemDataList) do
        local ItemCell = require("ui/bag/item_cell"):create(v.id, self)
        table.insert(self.itemCellList, ItemCell)
        ItemCell:startLoad(v.id)
    end
end

function BagUI:refreshContentSize()
    local contentHeight =  (CELL_HEIGHT + CELL_GAP) * (#self.emptyCellUIList + self.bagItemListCount)/4
    self.content.sizeDelta = {x = 0, y = contentHeight}
end

function BagUI:onCover()
end

function BagUI:onReShow()
    for _, v in ipairs (self.itemCellList) do
        v:onRefresh()
    end
    local params = {
        type = self.type
    }
    self:onRefresh(params)
end

function BagUI:onInitEvent()
    EventSystem:addListener(UIConst.EVENT_TYPE.BAG_DEL_CELL_EVENT, function() self:delCellTransform(self.curCellID) end)
end

function BagUI:backBtnOnClick()
    self:closeUI()
end

function BagUI:equipmentBtnOnClick()
    local params = {
        type = BagConst.TYPE.EQUIPMENT
    }
    self:onRefresh(params)
end

function BagUI:inscriptionBtnOnClick()
    local params = {
        type = BagConst.TYPE.INSCRIPTION
    }
    self:onRefresh(params)
end

function BagUI:boxBtnOnClick()
    local params = {
        type = BagConst.TYPE.BOX
    }
    self:onRefresh(params)
end

function BagUI:oreBtnOnClick()
    local params = {
        type = BagConst.TYPE.ORE
    }
    self:onRefresh(params)
end

function BagUI:clearItems()
    for i,v in ipairs (self.itemCellList) do
        v:delete()
    end
    for i,v in ipairs (self.emptyCellUIList) do
        v:delete()
    end
    self.allCellsList = {}
    self.itemCellList = {}
    self.emptyCellUIList = {}
end

function BagUI:onClose()
end

return BagUI


