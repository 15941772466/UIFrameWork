local LoginUI = class("BagUI", BaseUI)
LoginUI.uiName = "loginUI"
LoginUI.uiNode = "normal"
LoginUI.resPath = "Assets/res/prefabs/login_ui.prefab"
LoginUI.eventList = {}

function LoginUI:onLoadComplete()
    self.loginBtn = self.uiTransform:Find("login_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.loginBtn.onClick:AddListener(self.loginBtnOnClick)
end

function LoginUI:onRefresh()
    --刷新
end

function LoginUI:onClose()
    self:removeEvent(UIConst.eventType.LOGIN_EVENT)
end

function LoginUI:onInitEvent()
    self:registerEvent(UIConst.eventType.LOGIN_EVENT, self.loginEvent)
end

function LoginUI:getResPath()
    return self.resPath
end

function LoginUI:loginBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.LOGIN_EVENT)
end

function LoginUI:loginEvent()
    LoginUI:closeUI("loginUI")
    UIManager:openUI(UIConst.uiType.MAIN_UI)
end

return LoginUI