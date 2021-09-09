local UIManager = class("UIManager")

---- 类型
local TypeOfGameObject = typeof(CS.UnityEngine.GameObject)

---- 路径常量
local UI_ROOT_PATH ="Assets/res/prefabs/ui_root.prefab"

---- 单例
function UIManager:getInstance()
    if self.instance == nil then
        self.instance = self.new()
    end
    return self.instance
end

---- 构造函数
function UIManager:ctor()
    self.windows = {}
    self.layers = {}

    --初始化ui_root
    self.ui_root = CS.UnityEngine.GameObject.Find(ui_root)
    if self.ui_root == nil then
        self.ui_root = self:loadGameObject(UI_ROOT_PATH,function(gameObject)
            Logger.log("加载ui_root完成")
            BaseLayer:ctor()
            return gameObject
        end)
    end
    --CS.UnityEngine.Object.DontDestroyOnLoad(self.ui_root)

end

---- 加载资源
function UIManager:loadAsset(assetPath, type, callback)
    CSMain:LoadAsset(assetPath, type, callback)
end

---- 加载gameObject
function UIManager:loadGameObject(path, callback)
    self:loadAsset(path, TypeOfGameObject, function(asset)
        local gameObject = CS.UnityEngine.Object.Instantiate(asset)
        --gameObject:SetActive(false)
        callback(gameObject)
    end)
end


---- 添加层级面板
function UIManager:addLayer(layer)
    --参数检查
    if type(layer) ~= "table" or layer == nil then
        Logger.logError("添加层级失败！")
        return false
    end
    if self.layers == nil then
        self.layers = {}
    end
    if self.layers[layer.name] == nil then
        self.layers[layer.name] = panel
        Logger.log("添加层级成功！")
        return true
    else
        Logger.logWarning("该层级已存在！")
        return false
    end
end

---- 删除层级面板
function UIManager:removeLayer(layer)
    if type(layer) ~= "table" or layer == nil or self.layers == nil then
        Logger.logError("删除层级失败！")
        return false
    end
    if self.layers[layer.name] ~= nil then
        self.layers[layer.name] = nil
        Logger.log("删除层级成功！")
        return true
    else
        Logger.log("删除层级失败！")
        return false
    end
end


return UIManager