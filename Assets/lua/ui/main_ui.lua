local MainUI = class("BagUI", BaseUI)
MainUI.uiName = "mainUI"
MainUI.uiNode = "normal"
MainUI.resPath = "Assets/res/prefabs/main_ui.prefab"
MainUI.eventList = {}

function MainUI:onLoadComplete()
    self.bagBtn = self.uiTransform:Find("bag_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.back_btn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.back_btn.onClick:AddListener(self.backBtnOnClick)
    self.bagBtn.onClick:AddListener(self.bagBtnOnClick)
end

function MainUI:onRefresh()
    --刷新
end

function MainUI:onClose()
    self:removeEvent(UIConst.eventType.BAG_EVENT)
    self:removeEvent(UIConst.eventType.MAIN_BACK_EVENT)
end

function MainUI:onInitEvent()
    self:registerEvent(UIConst.eventType.MAIN_BACK_EVENT, self.mainBackEvent)
    self:registerEvent(UIConst.eventType.BAG_EVENT, self.bagEvent)
end

function MainUI:getResPath()
    return self.resPath
end

function MainUI:backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.MAIN_BACK_EVENT)
end
function MainUI:bagBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_EVENT)
end

function MainUI:mainBackEvent()
    UIManager:openUI(UIConst.uiType.LOGIN_UI)
end
function MainUI:bagEvent()
    UIManager:openUI(UIConst.uiType.BAG_UI)
end

return MainUI