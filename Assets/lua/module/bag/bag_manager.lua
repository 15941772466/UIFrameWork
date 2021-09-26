local BagManager = {}

function BagManager:getBagItemList()
    return DataManager.bagData.bagItemList
end

function BagManager:getItemsNum()
    return DataManager.bagData:getAllItemsNum()
end

function BagManager:getItem(id)
    return DataManager.bagData.bagItemMap[id]
end

function BagManager:getPropNum(id)
    return DataManager.bagData:getItemNum(id)
end

function BagManager:useProp(id)
    DataManager.bagData:useItem(id)
end

--
--function BagManager:sellProp(id)
--    if self:getPropNum(id) > 0 then
--        BagDataManager.bagPropNumberMap[id] = BagDataManager.bagPropNumberMap[id] - 1
--        --增加金币
--        BagDataManager.coinsNum = BagDataManager.coinsNum + Config.data[id]["price"]
--    end
--end
return BagManager