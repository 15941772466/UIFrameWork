local BagData = class("BagData")
local BagConst = require "data/bag/bag_const"

function BagData:init(dataMap)
    self.bagItemDataList = {}
    self.bagItemDataMap = {}

    self.bagEquipmentDataList = {}
    self.bagEquipmentDataMap = {}

    self.bagInscriptionDataList = {}
    self.bagInscriptionDataMap = {}

    self.bagBoxDataList = {}
    self.bagBoxDataMap = {}

    self.bagOreDataList = {}
    self.bagOreDataMap = {}

    for i, v in pairs(dataMap) do
        local item = require("data/bag/item_entity"):create(i, v)
        self:differDataByType(i, item)
    end
end

function BagData:addItem(id, num)
    DataManager.data.bag[id] = num
    local item = require("data/bag/item_entity"):create(id, num)
    self:differDataByType(id, item)
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

function BagData:differDataByType(i, item)
    if item:getType() == BagConst.TYPE.EQUIPMENT then
        table.insert(self.bagEquipmentDataList, item)
        self.bagEquipmentDataMap[i] = item
    elseif item:getType() == BagConst.TYPE.INSCRIPTION then
        table.insert(self.bagInscriptionDataList, item)
        self.bagInscriptionDataMap[i] = item
    elseif item:getType() == BagConst.TYPE.BOX then
        table.insert(self.bagBoxDataList, item)
        self.bagBoxDataMap[i] = item
    elseif item:getType() == BagConst.TYPE.ORE then
        table.insert(self.bagOreDataList, item)
        self.bagOreDataMap[i] = item
    end
end

return BagData