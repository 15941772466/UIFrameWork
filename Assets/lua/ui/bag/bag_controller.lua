local BagController = {}

function BagController:getItems()
    return BagDataManager.bagPropNumberMap
end

function BagController:getPropNum(id)
    return BagDataManager.bagPropNumberMap[id]
end

function BagController:useProp(id)
    if self:getPropNum(id) > 0 then
        --减少数量
    end
end

function BagController:sellProp()
    if self:getPropNum(id) > 0 then
        --减少数量
        --增加金币
    end
end
return BagController