local BagUI = class("BagUI", BaseUI)
BagUI.uiName = "bagUI"
BagUI.uiNode = "popup"
BagUI.resPath = "Assets/res/prefabs/bag_ui.prefab"
local backBtn

function BagUI:init()
    backBtn = self.uiTransform:Find("back_btn"):GetComponent("UnityEngine.UI.Button")
    self:registerEvent()
end

function BagUI:registerEvent()
    EventSystem:addListener(UIConst.eventType.BAG_BACK_EVENT,self:bagBackEvent())
    backBtn.onClick:AddListener(self.backBtnOnClick)
end

function BagUI:removeEvent()

end

function BagUI:bagBackEvent()
    return function()
        UIManager:closeUI("bagUI")
    end
end

function BagUI.backBtnOnClick()
    EventSystem:sendEvent(UIConst.eventType.BAG_BACK_EVENT)
end

function BagUI:getResPath()
    return self.resPath
end

function BagUI:onLoadComplete()
    self:init()
end

return BagUI