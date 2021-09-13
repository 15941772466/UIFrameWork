local MainUI = class("BagUI", BaseUI)
MainUI.uiName = "mainUI"
MainUI.uiNode = "normal"
MainUI.resPath = "Assets/res/prefabs/main_ui.prefab"

local bagBtn,back_btn

function MainUI:init()
    bagBtn = self.uiTransform:Find("bag_btn"):GetComponent("UnityEngine.UI.Button")
    back_btn = self.uiTransform:Find("back_btn"):GetComponent("UnityEngine.UI.Button")
    self:registerEvent()
end

function MainUI:registerEvent()
    EventSystem:addListener(UIConst.eventType.MAIN_BACK_EVENT,self:mainBackEvent())
    back_btn.onClick:AddListener(self.backBtnOnClick)
    EventSystem:addListener(UIConst.eventType.BAG_EVENT,self:bagEvent())
    bagBtn.onClick:AddListener(self.bagBtnOnClick)
end

function MainUI:removeEvent()
    EventSystem:removeListener(UIConst.eventType.BAG_EVENT,self:bagEvent())
    EventSystem:removeListener(UIConst.eventType.MAIN_BACK_EVENT,self:mainBackEvent())
end

function MainUI:mainBackEvent()
    return function()
        Logger.log("mainBackBtnOnClick")
        UIManager:openUI(UIConst.uiType.LOGIN_UI)
    end
end

function MainUI.backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.MAIN_BACK_EVENT)
end

function MainUI:bagEvent()
    return function()
        Logger.log("bagBtnOnClick")
        UIManager:openUI(UIConst.uiType.BAG_UI)
        self:removeEvent()
    end
end

function MainUI.bagBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_EVENT)
end

function MainUI:getResPath()
    return self.resPath
end

function MainUI:onLoadComplete()
    self:init()
end

return MainUI