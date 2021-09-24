local DataManager = {}

function DataManager:init(data)
    local bagData =  require("data/bag_data"):create()
    bagData:init(data.bag)
end

return DataManager

