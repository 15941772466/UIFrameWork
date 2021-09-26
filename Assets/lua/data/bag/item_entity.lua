local items = require "config/item"
local ItemEntity = class("ItemEntity")

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

function ItemEntity:getName()
    return items.data[self.id]["name"]
end

function ItemEntity:getPrice()
    return items.data[self.id]["price"]
end

function ItemEntity:getDescribe()
    return items.data[self.id]["describe"]
end

function ItemEntity:getQuality()
    return items.data[self.id]["quality"]
end

function ItemEntity:getIcon()
    return "Assets/res/item/"..items.data[self.id]["icon"]
end

return ItemEntity