local LoginUI = class("BagUI", BaseUI)
LoginUI.uiName = "loginUI"
LoginUI.uiNode = "normal"
LoginUI.resPath = "Assets/res/prefabs/login_ui.prefab"

function LoginUI:onLoadComplete()
    self.loginBtn = self.uiTransform:Find("login_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.closed = true
end

function LoginUI:onRefresh()
    if self.closed then
        self.closed = false
        self.loginBtn.onClick:AddListener(self.loginBtnOnClick)
        --EventSystem:addListener(UIConst.eventType.LOGIN_EVENT, self:loginEvent())
    end
end

function LoginUI:onClose()
    --EventSystem:removeListener(UIConst.eventType.LOGIN_EVENT, self:loginEvent())
    Logger.log("onClose onClose onClose")
    self.closed = true
end

function LoginUI.loginBtnOnClick()
    LoginUI:closeUI("loginUI")
    UIManager:openUI(UIConst.uiType.MAIN_UI)
    --EventSystem:sendEvent(UIConst.eventType.LOGIN_EVENT)
end

function LoginUI:loginEvent()
    return function()
        self:closeUI("loginUI")

        UIManager:openUI(UIConst.uiType.MAIN_UI)
    end
end

function LoginUI:getResPath()
    return self.resPath
end

return LoginUI