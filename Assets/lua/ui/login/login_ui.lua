local LoginUI = class("BagUI", BaseUI)

function LoginUI:getNode()
    return UIConst.UI_NODE.NORMAL
end

function LoginUI:getResPath()
    return "Assets/res/prefabs/login_ui.prefab"
end

function LoginUI:onLoadComplete()
    self.loginBtn = self.uiTransform:Find("login_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.loginBtn.onClick:AddListener(function() self:loginBtnOnClick() end)
end

function LoginUI:onRefresh()
end

function LoginUI:onCover()
end

function LoginUI:onReShow()
end

function LoginUI:onInitEvent()
end

function LoginUI:loginBtnOnClick()
    self:closeUI()
    UIManager:openUI(UIConst.UI_TYPE.MAIN_UI)
end

function LoginUI:onClose()
end

return LoginUI