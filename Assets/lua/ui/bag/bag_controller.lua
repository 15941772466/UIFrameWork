local BagController = {}

function BagController:getCoinsNum()
    return BagDataManager.coinsNum
end

function BagController:getItems()
    return BagDataManager.bagPropNumberMap
end

function BagController:getItem(id)
    return Config.data[id]
end

function BagController:getPropNum(id)
    return BagDataManager.bagPropNumberMap[id]
end

function BagController:useProp(id)
    if self:getPropNum(id) > 0 then
        BagDataManager.bagPropNumberMap[id] = BagDataManager.bagPropNumberMap[id] - 1
    end
end

function BagController:sellProp(id)
    if self:getPropNum(id) > 0 then
        BagDataManager.bagPropNumberMap[id] = BagDataManager.bagPropNumberMap[id] - 1
        --增加金币
        BagDataManager.coinsNum = BagDataManager.coinsNum + Config.data[id]["price"]
    end
end
return BagController