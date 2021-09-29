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
    self.bagBtn.onClick:AddListener(function() self:bagBtnOnClick() end )
    self.backBtn.onClick:AddListener(function() self:mainBackBtnOnClick() end)
end

function MainUI:onRefresh()
    self:onCoinsRefresh()
end

function MainUI:onCover()

end

function MainUI:onReShow()
   self:onRefresh()
end

function MainUI:onInitEvent()
    EventSystem:addListener(UIConst.EVENT_TYPE.MAIN_COINS_REFRESH_EVENT, function() self:onCoinsRefresh() end)
end

function MainUI:onCoinsRefresh()
    local coins = DataManager.data.coinsNum
    self.coins.text = "金币： "..coins
end

function MainUI:mainBackBtnOnClick()
    UIManager:openUI(UIConst.UI_TYPE.LOGIN_UI)
end

function MainUI:bagBtnOnClick()
    UIManager:openUI(UIConst.UI_TYPE.BAG_UI, nil,4)
end

function MainUI:onClose()
    Logger.log("MainUI  关闭 ")
end

return MainUI