local items = require "config/item"
local BagManager = {}

function BagManager:init()
    self.cellTransformMap = {}
    self.ItemCellList = {}
end

function BagManager:getItem(id)
    return DataManager.bagData.bagItemDataMap[id]
end

function BagManager:getPropNum(id)
    return DataManager.bagData:getItemNum(id)
end

function BagManager:useProp(id)
    DataManager.bagData:useItem(id)
    if DataManager.bagData.bagItemDataMap[id].num == 0 then
        self:delCellTransform(id)
    end
end

function BagManager:sellProp(id)
    DataManager.bagData:useItem(id)
    if DataManager.bagData.bagItemDataMap[id].num == 0 then
        self:delCellTransform(id)
    end
    DataManager.data.coinsNum = DataManager.data.coinsNum + items.data[id]["price"]
end

function BagManager:delCellTransform(id)
    CS.UnityEngine.GameObject.Destroy(self.cellTransformMap[id-1].gameObject)
    DataManager.bagData:removeItem(id)
    self.cellTransformMap[id-1] = nil
    for i, v in ipairs (DataManager.bagData.bagItemDataList) do
        if v.id == id then
            table.remove(DataManager.bagData.bagItemDataList,i)
        end
    end
    for i, v in ipairs (self.ItemCellList) do
        if v.itemID == id then
            table.remove(self.ItemCellList,i)
        end
    end
end
return BagManager