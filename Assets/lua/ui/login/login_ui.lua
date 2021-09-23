local LoginUI = class("BagUI", BaseUI)

function LoginUI:getNode()
    return UIConst.UI_NODE.NORMAL
end

function LoginUI:getResPath()
    return "Assets/res/prefabs/login_ui.prefab"
end

function LoginUI:onLoadComplete()
    self.loginBtn = self.uiTransform:Find("login_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.loginBtn.onClick:AddListener(self.loginBtnOnClick)
end

function LoginUI:onRefresh()
    Logger.log("LoginUI  刷新 ")
end

function LoginUI:onClose()
    Logger.log("LoginUI  关闭 ")
end

function LoginUI:onCover()
    Logger.log("LoginUI  被覆盖 ")
end

function LoginUI:onReShow()
    Logger.log("LoginUI  被重新打开 ")
end

function LoginUI:onInitEvent()
    self:registerEvent(UIConst.EVENT_TYPE.LOGIN_EVENT, function() self:loginEvent() end )
end

function LoginUI:loginBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.LOGIN_EVENT)
end

function LoginUI:loginEvent()
    self:closeUI()
    UIManager:openUI(UIConst.UI_TYPE.MAIN_UI)
end

return LoginUI