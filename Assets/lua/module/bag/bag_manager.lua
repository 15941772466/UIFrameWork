local items = require "config/item"
local BagManager = {}

function BagManager:init()
    self.cellTransformMap = {}
end

function BagManager:getItem(id)
    return DataManager.bagData.bagItemMap[id]
end

function BagManager:getPropNum(id)
    return DataManager.bagData:getItemNum(id)
end

function BagManager:useProp(id)
    DataManager.bagData:useItem(id)
    if DataManager.bagData.bagItemMap[id].num == 0 then
        CS.UnityEngine.GameObject.Destroy(self.cellTransformMap[id-1].gameObject)
        DataManager.bagData:removeItem(id)
        self.cellTransformMap[id-1] = nil
    end
end

function BagManager:sellProp(id)
    DataManager.bagData:useItem(id)
    if DataManager.bagData.bagItemMap[id].num == 0 then
        CS.UnityEngine.GameObject.Destroy(self.cellTransformMap[id-1].gameObject)
        DataManager.bagData:removeItem(id)
        self.cellTransformMap[id-1] = nil
    end
    DataManager.data.coinsNum = DataManager.data.coinsNum + items.data[id]["price"]
end

return BagManager