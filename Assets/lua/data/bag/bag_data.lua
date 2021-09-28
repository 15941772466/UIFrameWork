local BagData = class("BagData")

function BagData:init(dataMap)
    self.bagItemDataList = {}
    self.bagItemDataMap = {}
    self.cellTransformMap = {}
    for i, v in pairs(dataMap) do
        local item = require("data/bag/item_entity"):create(i, v)
        table.insert(self.bagItemDataList, item)
        self.bagItemDataMap[i] = item
    end
end

function BagData:addItem(id, num)

end

function BagData:useItem(id)
    self.bagItemDataMap[id].num = self.bagItemDataMap[id].num - 1
end

function BagData:removeItem(id)
    for i, v in ipairs (self.bagItemDataList) do
        if v.id == id then
            table.remove(self.bagItemDataList, i)
        end
    end
end

function BagData:getItemNum(id)
    return self.bagItemDataMap[id]:getNum()
end

function BagData:getItemQuality(id)
    return self.bagItemDataMap[id]:getQuality()
end

function BagData:getAllItemsNum()
    return #self.bagItemDataList
end
return BagData