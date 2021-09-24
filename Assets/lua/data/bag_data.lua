local BagData = {}

function BagData:init(dataList)
    BagData.bagDataList = {}
    BagData.bagDataMap = {}
    for _, v in ipairs(dataList) do
        local item = require("data/itemEntity"):create(v.id,v.num)
        table.insert(self.bagDataList, item)
        self.bagDataMap[v.id] = v
    end
end

function BagData:addItem(id, num)

end

function BagData:useItem(id)

end

function BagData:removeItem(id)

end

function BagData:getItemNum(id)
    return self.bagDataMap[id]:getNum()
end

function BagData:getItemQuality(id)
    return self.bagDataMap[id]:getQuality()
end

return BagData