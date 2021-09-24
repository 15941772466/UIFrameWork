local MainUI = class("BagUI", BaseUI)

function MainUI:getNode()
    return UIConst.UI_NODE.NORMAL
end

function MainUI:getResPath()
    return "Assets/res/prefabs/main_ui.prefab"
end

function MainUI:onLoadComplete()
    self.coins = self.uiTransform:Find("coins_num"):GetComponent(typeof(CS.UnityEngine.UI.Text))
    self.bagBtn = self.uiTransform:Find("bag_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.backBtn = self.uiTransform:Find("back_btn"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.bagBtn.onClick:AddListener(self.bagBtnOnClick)
    self.backBtn.onClick:AddListener(self.backBtnOnClick)
end

function MainUI:onRefresh()
    local coins = BagController:getCoinsNum()
    self.coins.text = "金币： "..coins
end

function MainUI:onClose()
    Logger.log("MainUI  关闭 ")
end

function MainUI:onCover()
    Logger.log("MainUI  被覆盖 ")
end

function MainUI:onReShow()
   self:onRefresh()
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