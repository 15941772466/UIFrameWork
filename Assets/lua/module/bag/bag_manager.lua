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
        --物品销毁
        CS.UnityEngine.GameObject.Destroy(self.cellTransformMap[id-1].gameObject)

        --数据清空
        self.cellTransformMap[id-1] = nil
        for i, v in ipairs (DataManager.bagData.bagItemList) do
            if v.id == id then
                table.remove(DataManager.bagData.bagItemList, i)
            end
        end
    end
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