local MainUI = class("BagUI", BaseUI)
MainUI.uiName = "mainUI"
MainUI.uiNode = "normal"
MainUI.resPath = "Assets/res/prefabs/main_ui.prefab"

function MainUI:onLoadComplete()
    self.bagBtn = self.uiTransform:Find("bag_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.back_btn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.opened = true
end

function MainUI:onRefresh()
    if self.opened then
        self:registerEvent()
    end
end

function MainUI:onClose()
    Logger.log("执行到MainUI:onClose()")
    self.opened = false
    self:removeEvent()
end

function MainUI:registerEvent()
    EventSystem:addListener(UIConst.eventType.MAIN_BACK_EVENT, self.mainBackEvent)
    self.back_btn.onClick:AddListener(self.backBtnOnClick)
    EventSystem:addListener(UIConst.eventType.BAG_EVENT, self.bagEvent)
    self.bagBtn.onClick:AddListener(self.bagBtnOnClick)
end

function MainUI:removeEvent()
    EventSystem:removeListener(UIConst.eventType.BAG_EVENT, self.bagEvent)
    EventSystem:removeListener(UIConst.eventType.MAIN_BACK_EVENT, self.mainBackEvent)
end

function MainUI.mainBackEvent()
    UIManager:openUI(UIConst.uiType.LOGIN_UI)
end

function MainUI.backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.MAIN_BACK_EVENT)
end

function MainUI.bagEvent()
    UIManager:openUI(UIConst.uiType.BAG_UI)
end

function MainUI.bagBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_EVENT)
end

function MainUI:getResPath()
    return self.resPath
end

return MainUI