local items = require "config/item"
local BagManager = {}

function BagManager:useProp(id)
    DataManager.bagData:useItem(id)
    if DataManager.bagData.bagItemDataMap[id].num == 0 then
        EventSystem:sendEvent(UIConst.EVENT_TYPE.BAG_DEL_CELL_EVENT)
    end
end

function BagManager:sellProp(id)
    DataManager.bagData:useItem(id)
    if DataManager.bagData.bagItemDataMap[id].num == 0 then
        EventSystem:sendEvent(UIConst.EVENT_TYPE.BAG_DEL_CELL_EVENT)
    end
    DataManager.data.coinsNum = DataManager.data.coinsNum + items.data[id]["price"]
    EventSystem:sendEvent(UIConst.EVENT_TYPE.MAIN_COINS_REFRESH_EVENT)
end

return BagManager