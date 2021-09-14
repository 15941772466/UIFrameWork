local LoginUI = class("BagUI", BaseUI)
LoginUI.uiName = "loginUI"
LoginUI.uiNode = "normal"
LoginUI.resPath = "Assets/res/prefabs/login_ui.prefab"

function LoginUI:onLoadComplete()
    self.loginBtn = self.uiTransform:Find("login_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.opened = true
end

function LoginUI:onRefresh()
    if self.opened then
        self.loginBtn.onClick:AddListener(self.loginBtnOnClick)
        EventSystem:addListener(UIConst.eventType.LOGIN_EVENT, self.loginEvent)
    end
end

function LoginUI:onClose()
    EventSystem:removeListener(UIConst.eventType.LOGIN_EVENT, self.loginEvent)
    self.opened = false
end

function LoginUI.loginBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.LOGIN_EVENT)
end

function LoginUI.loginEvent()
    LoginUI:closeUI("loginUI")
    UIManager:openUI(UIConst.uiType.MAIN_UI)
end

function LoginUI:getResPath()
    return self.resPath
end

return LoginUI