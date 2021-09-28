local DataManager = {}

--模拟后端数据
DataManager.data = {}

function DataManager:init()
    self.data.coinsNum = 100

    self.data.bag = {
        [1] = 2, [2] = 2, [3] = 2, [4] = 2,
        [5] = 1, [6] = 1, [7] = 1, [8] = 1,
        [9] = 1, [10] = 1, [11] = 1, [12] = 1,
        [13] = 1, [14] = 1, [15] = 1, [16] = 1,
        [17] = 1, [18] = 1, [19] = 1, [20] = 1,
        [21] = 1, [22] = 1, [23] = 1, [24] = 1,
        [50] = 1
    }
    self.bagData = require("data/bag/bag_data"):create()
    self.bagData:init(self.data.bag)
end

return DataManager

