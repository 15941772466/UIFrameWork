local LoginUI = class("BagUI", BaseUI)
LoginUI.uiName = "loginUI"
LoginUI.uiNode = "normal"
LoginUI.resPath = "Assets/res/prefabs/login_ui.prefab"
local loginBtn

function LoginUI:init()
    loginBtn = self.uiTransform:Find("login_btn"):GetComponent("UnityEngine.UI.Button")
    self:registerEvent()
end

function LoginUI:registerEvent()
    EventSystem:addListener(UIConst.eventType.LOGIN_EVENT,self:loginEvent())
    loginBtn.onClick:AddListener(self.loginBtnOnClick)
    --self:removeEvent()
end

function LoginUI:removeEvent()
    EventSystem:removeListener(UIConst.eventType.LOGIN_EVENT,self:loginEvent())
end

function LoginUI:loginEvent()
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
end

function LoginUI.loginBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.LOGIN_EVENT)
end

return LoginUI