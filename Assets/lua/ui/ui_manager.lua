local UIManager = {}
local TypeOfGameObject = typeof(CS.UnityEngine.GameObject)
local UI_ROOT_PATH = "Assets/res/prefabs/ui_root.prefab"

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
    self:loadGameObject(UI_ROOT_PATH,function(gameObject)
        self.uiRoot = gameObject
        self.normal = self.uiRoot.transform:Find("normal")
        self.popup = self.uiRoot.transform:Find("popup")
        self.mask = self.uiRoot.transform:Find("popup/mask")
        self.mask.gameObject:SetActive(false)
        self:openUI(UIConst.uiType.LOGIN_UI)
        --异步加载测试
        --self:openUI(UIConst.uiType.MAIN_UI)
        --self:openUI(UIConst.uiType.BAG_UI)
        --self:openUI(UIConst.uiType.LOGIN_UI)
        --self:openUI(UIConst.uiType.MAIN_UI)
        --self:openUI(UIConst.uiType.BAG_UI)
    end)
end

local index = 0
UIManager.uiTransform = {}

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
        return self.windows[uiType]
    else
        return nil
    end
end

function UIManager:closeUI(uiName)
    for _,v in pairs(self.uiList) do
        if v.uiName == uiName then
            v:hide()
            self.mask.gameObject:SetActive(false)
            break
        end
    end
end

function UIManager:deleteUI(uiType)
    local uiObj = self.windows[uiType]
    for _,v in pairs(self.uiList) do
        if v.uiName == uiObj.uiName then
            v:delete()
            table.remove(self.uiList,uiObj)
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
    for _,v in pairs(self.uiList) do
        v:delete()
    end
    self.uiList = {}
    self.windows = {}
end

return UIManager