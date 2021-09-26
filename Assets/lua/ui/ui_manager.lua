local UIManager = {}
local TypeOfGameObject = typeof(CS.UnityEngine.GameObject)
local TypeOfSprite = typeof(CS.UnityEngine.Sprite)

local UI_ROOT_PATH = "Assets/res/prefabs/ui_root.prefab"
local UI_CACHE_MAX = 4
local index = 0

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

---- 加载sprite
function UIManager:loadSprite(path, callback)
    self:loadAsset(path, TypeOfSprite, function(asset)
        callback(asset)
    end)
end

function UIManager:init()
    self.uiList = {}  --存活的ui   value: uiObj
    self.uiCacheList = {}   --value: uiObj
    self.uiTransformMap = {}  --key: "index"  value: uiTransform   用来排序
    self:loadGameObject(UI_ROOT_PATH, function(gameObject)
        self.uiRoot = gameObject
        self.normal = self.uiRoot.transform:Find(UIConst.UI_NODE.NORMAL)
        self.mask = self.uiRoot.transform:Find(UIConst.UI_NODE.MASK)
        self.mask.gameObject:SetActive(false)
        self:openUI(UIConst.UI_TYPE.LOGIN_UI)
        --self:openUI(UIConst.UI_TYPE.MAIN_UI)
        --self:openUI(UIConst.UI_TYPE.BAG_UI)
        --self:closeUIByType(UIConst.UI_TYPE.LOGIN_UI)
    end)
end

function UIManager:openUI(uiType, itemID)
    local uiObj
    index = index + 1

    uiObj = self:checkOpen(uiType)
    if uiObj then
        uiObj.index = index
        uiObj:show(index)
        return
    end
    uiObj = self:getFromCacheList(uiType)
    if uiObj then
        uiObj.index = index
        table.insert(self.uiList, uiObj)
        uiObj:show(index, itemID)
        return
    end
    uiObj = require(uiType):create()
    uiObj.index = index
    uiObj.uiType = uiType
    table.insert(self.uiList, uiObj)
    uiObj:startLoad(index, itemID)
end

function UIManager:getFromCacheList(uiType)
    local uiObj
    for i, v in ipairs (self.uiCacheList) do
        if v.uiType == uiType then
            uiObj = v
            table.remove(self.uiCacheList, i)
            return uiObj
        end
    end
    return nil
end

function UIManager:checkOpen(uiType)
    for _, v in ipairs (self.uiList) do
        if v.uiType == uiType then
            return v
        end
    end
    return nil
end

function UIManager:closeUI(uiObj)
    for i, v in ipairs (self.uiList) do
        if v == uiObj then
            if #self.uiCacheList < UI_CACHE_MAX then
                v:hide()
                if uiObj.uiTransform then
                    table.insert(self.uiCacheList, v)
                end
            else
                v:delete()
            end
            if uiObj.uiTransform then
                table.remove(self.uiList, i)
            end
            break
        end
    end
    if uiObj.uiNode == UIConst.UI_NODE.POPUP then
        self.mask.gameObject:SetActive(false)
    end
end

function UIManager:closeUIByType(uiType)
    local uiObj
    for _, v in ipairs (self.uiList) do
        if v.uiType == uiType then
            uiObj = v
        end
    end

    if #self.uiCacheList < UI_CACHE_MAX then
        uiObj:hide()
        if uiObj.uiTransform then
            table.insert(self.uiCacheList, uiObj)
        end
    else
        uiObj:delete()
    end

    if uiObj.uiTransform then
        for i, v in ipairs (self.uiList) do
            if v.uiType == uiType then
                table.remove(self.uiList, i)
                break
            end
        end
    end

    if uiObj.uiNode == UIConst.UI_NODE.POPUP then
        self.mask.gameObject:SetActive(false)
    end
end

return UIManager