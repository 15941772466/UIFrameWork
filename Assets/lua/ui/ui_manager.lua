local UIManager = {}
local TypeOfGameObject = typeof(CS.UnityEngine.GameObject)
local UI_ROOT_PATH = "Assets/res/prefabs/ui_root.prefab"
local UI_CACHE_MAX = 4

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
    self.uiObjMap = {}
    self.uiTransformMap = {}
    self.uiCacheList = {}
    self:loadGameObject(UI_ROOT_PATH, function(gameObject)
        self.uiRoot = gameObject
        self.normal = self.uiRoot.transform:Find(UIConst.UI_NODE.NORMAL)
        self.mask = self.uiRoot.transform:Find(UIConst.UI_NODE.MASK)
        self.mask.gameObject:SetActive(false)
        self:openUI(UIConst.UI_TYPE.MAIN_UI)
        self:openUI(UIConst.UI_TYPE.BAG_UI)
        self:openUI(UIConst.UI_TYPE.LOGIN_UI)
    end)
end

function UIManager:openUI(uiType)
    local uiObj
    local topUISiblingIndex
    local topUI = self.uiList[#self.uiList]
    if topUI then
        topUISiblingIndex = #self.uiList + 1
        topUI:onCover()
    else
        topUISiblingIndex = 1
    end

    uiObj = self:getFromCacheList(uiType)
    if uiObj then
        if self:checkOpen(uiType) then
            uiObj:show(topUISiblingIndex)
            table.insert(self.uiList, uiObj)
            return
        end
        table.insert(self.uiList, uiObj)
        uiObj:reShow(topUISiblingIndex)
        return
    end

    uiObj = require(uiType):create()
    table.insert(self.uiList, uiObj)
    self.uiObjMap[uiType] = uiObj
    --Logger.log(uiType)
    uiObj:startLoad(topUISiblingIndex)
end

function UIManager:checkOpen(uiType)
    return self.uiObjMap[uiType].gameObject.activeSelf
end

function UIManager:getFromCacheList(uiType)
    if self.uiObjMap[uiType] ~= nil then
        for i, v in ipairs (self.uiCacheList) do
            if v == self.uiObjMap[uiType] then
                table.remove(self.uiCacheList, i)
            end
        end
        return self.uiObjMap[uiType]
    else
        return nil
    end
end

function UIManager:closeUI(uiObj)
    for _, v in ipairs (self.uiList) do
        if v == uiObj then
            if #self.uiCacheList < UI_CACHE_MAX then
                v:hide()
                table.insert(self.uiCacheList, v)
            else
                v:delete()
            end
            v:removeAllEvents()
            v:onClose()
            if v.uiNode == UIConst.UI_NODE.POPUP then
                self.mask.gameObject:SetActive(false)
            end
            break
        end
    end
end

function UIManager:closeUIByType(uiType)
    local uiObj = self.uiObjMap[uiType]
    if #self.uiCacheList < UI_CACHE_MAX then
        uiObj:hide()
        table.insert(self.uiCacheList, uiObj)
    else
        for i, v in ipairs (self.uiList) do
            if v == uiObj then
                v:delete()
                table.remove(self.uiList, i)
                uiObj:delete()
                break
            end
        end
    end
    uiObj:removeAllEvents()
    uiObj:onClose()
    if uiObj.uiNode == UIConst.UI_NODE.POPUP then
        self.mask.gameObject:SetActive(false)
    end
end

function UIManager:deleteUIByType(uiType)
    local uiObj = self.uiObjMap[uiType]
    for i, v in ipairs (self.uiList) do
        if v == uiObj then
            v:delete()
            table.remove(self.uiList, i)
            break
        end
    end
    self.uiObjMap[uiType] = nil
end

function UIManager:closeAllUI()
    for _, v in ipairs (self.uiList) do
        v:hide()
    end
end

function UIManager:deleteAllUI()
    for _, v in ipairs (self.uiList) do
        v:delete()
    end
    self.uiList = {}
    self.uiObjMap = {}
end

return UIManager