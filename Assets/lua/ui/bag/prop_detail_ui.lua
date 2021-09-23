local PropDetailUI = class("PropDetailUI", BaseUI)

function PropDetailUI:getNode()
    return UIConst.UI_NODE.POPUP
end

function PropDetailUI:getResPath()
    return "Assets/res/prefabs/prop_detail_ui.prefab"
end

function PropDetailUI:onLoadComplete()
    self.introduction = self.uiTransform:Find("introduction"):GetComponent(typeof(CS.UnityEngine.UI.Text))
    self.introduction.text = "道具介绍："
    self.useBtn = self.uiTransform:Find("use"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.useBtn.onClick:AddListener(self.useBtnOnClick)
    self.sellBtn = self.uiTransform:Find("sell"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.sellBtn.onClick:AddListener(self.sellBtnOnClick)
    self.propBackBtn = self.uiTransform:Find("back"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.propBackBtn.onClick:AddListener(self.propBackBtnOnClick)
end

function PropDetailUI:onRefresh()
    Logger.log("PropDetailUI  刷新 ")
end

function PropDetailUI:onClose()
    Logger.log("PropDetailUI  关闭 ")
end

function PropDetailUI:onCover()
    Logger.log("PropDetailUI  被覆盖 ")
end

function PropDetailUI:onReShow()
    Logger.log("PropDetailUI  被重新打开 ")
end

function PropDetailUI:onInitEvent()
    self:registerEvent(UIConst.EVENT_TYPE.PROP_USE_EVENT, function() self:propUseEvent() end)
    self:registerEvent(UIConst.EVENT_TYPE.PROP_SELL_EVENT, function() self:propSellEvent() end)
    self:registerEvent(UIConst.EVENT_TYPE.PROP_BACK_EVENT, function() self:propBackEvent() end)
end

function PropDetailUI:useBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.PROP_USE_EVENT)
end

function PropDetailUI:propUseEvent()
    --控制层
end

function PropDetailUI:sellBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.PROP_SELL_EVENT)
end

function PropDetailUI:propSellEvent()
   --控制层
end

function PropDetailUI:propBackBtnOnClick()
    EventSystem:sendEvent(UIConst.EVENT_TYPE.PROP_BACK_EVENT)
end
--
function PropDetailUI:propBackEvent()
   self:closeUI()
end

return PropDetailUI