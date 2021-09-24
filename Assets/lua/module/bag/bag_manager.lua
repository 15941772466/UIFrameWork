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
--function BagManager:getCoinsNum()
--    return BagDataManager.coinsNum
--end
--
--function BagManager:getItems()
--    return BagDataManager.bagPropNumberMap
--end
--

--
--function BagManager:getPropNum(id)
--    return BagDataManager.bagPropNumberMap[id]
--end
--
--function BagManager:useProp(id)
--    DataManager:useItem(id)
--    --if self:getPropNum(id) > 0 then
--    --    BagDataManager.bagPropNumberMap[id] = BagDataManager.bagPropNumberMap[id] - 1
--    --end
--end
--
--function BagManager:sellProp(id)
--    if self:getPropNum(id) > 0 then
--        BagDataManager.bagPropNumberMap[id] = BagDataManager.bagPropNumberMap[id] - 1
--        --增加金币
--        BagDataManager.coinsNum = BagDataManager.coinsNum + Config.data[id]["price"]
--    end
--end
return BagManager