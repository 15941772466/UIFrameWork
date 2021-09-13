local LoginUI = class("BagUI", BaseUI)
LoginUI.uiName = "loginUI"
LoginUI.resPath = "Assets/res/prefabs/login_ui.prefab"
local login_btn

function LoginUI:init()
    login_btn = self.uiTransform:Find("login_btn"):GetComponent("UnityEngine.UI.Button")
end

function LoginUI:registerEvent()
    EventSystem:addListener(UIConst.eventType.LOGIN_UI,self:doEvent())
    login_btn.onClick:AddListener(self.loginBtnOnClick)
    --self:removeEvent()
end

function LoginUI:removeEvent()
    EventSystem:removeListener(UIConst.eventType.LOGIN_UI,self:doEvent())
end

function LoginUI:doEvent()
    return function()
        UIManager:closeUI("loginUI")
        UIManager:openUI(UIConst.uiType.MAIN_UI)
    end
end

function LoginUI:getResPath()
    return self.resPath
end

function LoginUI:onLoadComplete()
    self:init()
    self:registerEvent()
end

function LoginUI.loginBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.LOGIN_UI)
end

return LoginUI