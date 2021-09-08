local UIManager = {}

local TypeOfGameObject = typeof(CS.UnityEngine.GameObject)

---- 加载资源
function UIManager:loadAsset(assetPath, type, callback)
    CSMain:LoadAsset(assetPath, type, callback)
end

---- 加载gameObject
function UIManager:loadGameObject(path, callback)
    self:loadAsset(path, TypeOfGameObject, function(asset)
        local gameObject = CS.UnityEngine.Object.Instantiate(asset)
        callback(gameObject)
    end)
end

return UIManager