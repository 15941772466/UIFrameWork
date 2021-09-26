local BagData = class("BagData")

function BagData:init(dataMap)
    self.bagItemList = {}
    self.bagItemMap = {}
    for i, v in pairs(dataMap) do
        local item = require("data/bag/item_entity"):create(i, v)
        table.insert(self.bagItemList, item)
        self.bagItemMap[i] = item
    end
end

function BagData:addItem(id, num)

end

function BagData:useItem(id)
    self.bagItemMap[id].num = self.bagItemMap[id].num - 1
end

function BagData:removeItem(id)

end

function BagData:getItemNum(id)
    return self.bagItemMap[id]:getNum()
end

function BagData:getItemQuality(id)
    return self.bagItemMap[id]:getQuality()
end

function BagData:getAllItemsNum()
    return #self.bagItemList
end
return BagData