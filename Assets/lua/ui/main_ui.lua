local MainUI = class("BagUI", BaseUI)

function MainUI:getNode()
    return UIConst.UI_NODE.NORMAL
end

function MainUI:getResPath()
    return "Assets/res/prefabs/main_ui.prefab"
end

function MainUI:onLoadComplete()
    self.bagBtn = self.uiTransform:Find("bag_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.bagBtn.onClick:AddListener(self.bagBtnOnClick)
    self.backBtn.onClick:AddListener(self.backBtnOnClick)
end

function MainUI:onRefresh()
end

function MainUI:onClose()
end

function MainUI:onCover()
end

function MainUI:onInitEvent()
    self:registerEvent(UIConst.EVENT_TYPE.MAIN_BACK_EVENT, function() self:mainBackEvent() end)
    self:registerEvent(UIConst.EVENT_TYPE.BAG_EVENT, function() self:bagEvent() end)
end

function MainUI:backBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.MAIN_BACK_EVENT)
end

function MainUI:bagBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.BAG_EVENT)
end

function MainUI:mainBackEvent()
    UIManager:openUI(UIConst.UI_TYPE.LOGIN_UI)
end

function MainUI:bagEvent()
    UIManager:openUI(UIConst.UI_TYPE.BAG_UI)
end

return MainUI