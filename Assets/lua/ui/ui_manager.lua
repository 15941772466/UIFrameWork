local UIManager = {}
local TypeOfGameObject = typeof(CS.UnityEngine.GameObject)
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

function UIManager:init()
    self.uiList = {}
    self.windows = {}
    self.uiTransform = {}
    self.uiCacheList = {}
    self:loadGameObject(UI_ROOT_PATH, function(gameObject)
        self.uiRoot = gameObject
        self.normal = self.uiRoot.transform:Find("normal")
        self.popup = self.uiRoot.transform:Find("popup")
        self.mask = self.uiRoot.transform:Find("popup/mask")
        self.mask.gameObject:SetActive(false)
        self:openUI(UIConst.uiType.LOGIN_UI)
    end)
end

function UIManager:openUI(uiType)
    index = index + 1
    local uiObj
    uiObj = self:checkOpen(uiType)
    if uiObj then
        uiObj:show(index)
        return
    end
    uiObj = require(uiType):create()
    table.insert(self.uiList, uiObj)
    self.windows[uiType]=uiObj
    uiObj:startLoad(index)
end

function UIManager:checkOpen(uiType)
    if self.windows[uiType] ~= nil then
        for i, v in pairs(self.uiCacheList) do
            if v.uiName == self.windows[uiType].uiName then
                table.remove(self.uiCacheList, i)
            end
        end
        return self.windows[uiType]
    else
        return nil
    end
end

function UIManager:closeUI(uiName)
    for i,v in pairs(self.uiList) do
        if v.uiName == uiName then
            if #self.uiCacheList < UI_CACHE_MAX then
                v:hide()
                table.insert(self.uiCacheList, v)
            else
                v:delete()
            end
            if v.uiNode == "popup" then
                self.mask.gameObject:SetActive(false)
            end
            break
        end
    end
end

function UIManager:deleteUI(uiType)
    local uiObj = self.windows[uiType]
    for i,v in pairs(self.uiList) do
        if v.uiName == uiObj.uiName then
            v:delete()
            table.remove(self.uiList ,i)
            break
        end
    end
    self.windows[uiType] = nil
end

function UIManager:closeAllUI()
    for _,v in pairs(self.uiList) do
        v:hide()
    end
end

function UIManager:deleteAllUI()
    for _ ,v in pairs(self.uiList) do
        v:delete()
    end
    self.uiList = {}
    self.windows = {}
end

return UIManager