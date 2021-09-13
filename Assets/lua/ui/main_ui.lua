local MainUI = class("BagUI", BaseUI)
MainUI.uiName = "mainUI"
MainUI.resPath = "Assets/res/prefabs/main_ui.prefab"

local bag_btn,back_btn

function MainUI:init()
    bag_btn = self.uiTransform:Find("bag_btn"):GetComponent("UnityEngine.UI.Button")
    back_btn = self.uiTransform:Find("back_btn"):GetComponent("UnityEngine.UI.Button")
    self:registerEvent()
end

function MainUI:registerEvent()
    EventSystem:addListener(UIConst.eventType.BACK_UI,self:backEvent())
    back_btn.onClick:AddListener(self.backBtnOnClick)
    EventSystem:addListener(UIConst.eventType.BAG_UI,self:bagEvent())
    bag_btn.onClick:AddListener(self.bagBtnOnClick)
end

function MainUI:removeEvent()
    EventSystem:removeListener(UIConst.eventType.BACK_UI,self:backEvent())
    EventSystem:removeListener(UIConst.eventType.BAG_UI,self:bagEvent())
end

function MainUI:backEvent()
    return function()
        UIManager:openUI(UIConst.uiType.LOGIN_UI)
    end
end

function MainUI.backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BACK_UI)
end

function MainUI:bagEvent()
    return function()
        UIManager:openUI(UIConst.uiType.BAG_UI)
    end
end

function MainUI.bagBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_UI)
end

function MainUI:getResPath()
    return self.resPath
end

function MainUI:onLoadComplete()
    self:init()
end

return MainUI