local BagData = class("BagData")

function BagData:init(dataMap)
    BagData.bagDataList = {}
    BagData.bagDataMap = {}
    for i, v in pairs(dataMap) do
        local item = require("data/itemEntity"):create(i, v)
        table.insert(self.bagDataList, item)
        self.bagDataMap[i] = item
    end
end

function BagData:addItem(id, num)

end

function BagData:useItem(id)
    self.bagDataMap[id].num = self.bagDataMap[id].num - 1
end

function BagData:removeItem(id)

end

function BagData:getItemNum(id)
    return self.bagDataMap[id]:getNum()
end

function BagData:getItemQuality(id)
    return self.bagDataMap[id]:getQuality()
end

function BagData:getAllItemsNum()
    return #self.bagDataList
end
return BagData