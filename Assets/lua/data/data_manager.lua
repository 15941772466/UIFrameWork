local DataManager = {}

--模拟后端数据
DataManager.data = {}

function DataManager:init()
    self.data.bag = {
        [1] = 10,
        [2] = 5,
        [3] = 15
    }
    self.data.coinsNum = 100
    local bagData = require("data/bag_data"):create()
    bagData:init(self.data.bag)
end

function DataManager:getCoinsNum()
    return self.data.coinsNum
end

return DataManager

