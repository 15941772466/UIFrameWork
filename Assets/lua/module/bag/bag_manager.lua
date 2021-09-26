local BagManager = {}

local BagData = require "data/bag_data"

function BagManager:getBagDataList()
    return BagData.bagDataList
end

function BagManager:getItemsNum()
    return BagData:getAllItemsNum()
end

function BagManager:getItem(id)
    return BagData.bagDataMap[id]
end

function BagManager:getPropNum(id)
    return BagData:getItemNum(id)
end

function BagManager:useProp(id)
    BagData:useItem(id)
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