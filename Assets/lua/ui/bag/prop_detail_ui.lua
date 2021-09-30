local BagManager = require "module/bag/bag_manager"
local PropDetailUI = class("PropDetailUI", BaseUI)

function PropDetailUI:ctor()
end

function PropDetailUI:getNode()
    return UIConst.UI_NODE.POPUP
end

function PropDetailUI:getResPath()
    return "Assets/res/prefabs/prop_detail_ui.prefab"
end

function PropDetailUI:onLoadComplete()
    self.introduction = self.uiTransform:Find("introduction"):GetComponent(typeof(CS.UnityEngine.UI.Text))
    self.number = self.uiTransform:Find("number"):GetComponent(typeof(CS.UnityEngine.UI.Text))
    self.useBtn = self.uiTransform:Find("use"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.useBtn.onClick:AddListener(function() self:useBtnOnClick() end)

    self.sellBtn = self.uiTransform:Find("sell"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.sellBtn.onClick:AddListener(function() self:sellBtnOnClick() end)

    self.propBackBtn = self.uiTransform:Find("back"):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.propBackBtn.onClick:AddListener(function() self:propBackOnClick() end)
end

function PropDetailUI:onRefresh(params)
    self.itemID = params.itemID
    local item = DataManager.bagData.bagItemDataMap[self.itemID]
    if item:getNum() == 0 then
        self:closeUI()
    end
    self.introduction.text = "道具介绍：\n\n"..item:getName()..":\n".."    "..item:getDescribe()
    self.number.text = "剩余数量："..item:getNum()
end

function PropDetailUI:onCover()
end

function PropDetailUI:onReShow()
end

function PropDetailUI:onInitEvent()
end

function PropDetailUI:useBtnOnClick()
    BagManager:useProp(self.itemID)
    local params = {
        itemID = self.itemID
    }
    self:onRefresh(params)
end

function PropDetailUI:sellBtnOnClick()
    BagManager:sellProp(self.itemID)
    local params = {
        itemID = self.itemID
    }
    self:onRefresh(params)
end

function PropDetailUI:propBackOnClick()
    self:closeUI()
end

function PropDetailUI:onClose()
end

return PropDetailUI