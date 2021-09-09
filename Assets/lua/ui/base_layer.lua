local BaseLayer = class("BaseLayer","BaseUI")

local NORMAL_LAYER = "Assets/res/prefabs/normal.prefab"

---- 构造函数
function BaseLayer:ctor(layerName)
    local obj = UIManager:loadGameObject(NORMAL_LAYER, function(gameObject)
        Logger.log("normal层级加载完成！")
        return gameObject
    end)

    obj.transform:SetParent(UIManager:getInstance().ui_root.transform)   ---- 出错了
    BaseLayer.super:ctor(layerName,uiTransform)
end

---- 打开层级
function BaseLayer:show()
    BaseLayer.super:show()
    UIManager:getInstance():addLayer()
end

---- 关闭层级
function BaseLayer:hide()
    BaseLayer.super:hide()
end

---- 删除层级
function BaseLayer:delete()
    UIManager:getInstance():removeLayer()
    BaseLayer.super.delete()
end

return BaseLayer