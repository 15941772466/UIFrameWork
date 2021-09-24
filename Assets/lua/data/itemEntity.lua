local ItemEntity = class("ItemEntity")
local items = require "config/item"

function ItemEntity:ctor(id, num)
    self.id = id
    self.num = num
end

function ItemEntity:getID()
    return self.id
end

function ItemEntity:getNum()
    return self.num
end

function ItemEntity:getQuality()
    return items.data[self.id]["quality"]
end

return ItemEntity