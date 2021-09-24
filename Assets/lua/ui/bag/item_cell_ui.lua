local ItemCellUI = class("ItemCellUI")

function ItemCellUI:ctor(itemID)
    self.itemID = itemID
end

function ItemCellUI:getNode()
    return UIConst.UI_NODE.BAG
end

function ItemCellUI:getResPath()
    return "Assets/res/prefabs/item_cell_ui.prefab"
end

function ItemCellUI:startLoad()
    local path = self:getResPath()
    UIManager:loadGameObject(path, function(gameObject)
        self.eventMap = {}
        self.eventTypeList = {}
        self.gameObject = gameObject
        self.uiNode = self:getNode()
        if not UIManager.bagNode then
            UIManager.bagNode = UIManager.uiRoot.transform:Find(UIConst.UI_NODE.BAG)
        end
        self.gameObject.transform:SetParent(UIManager.bagNode.transform, false)
        self.uiTransform = gameObject.transform
        self:onLoadComplete()
        self:onInitEvent()
        self:onRefresh()

    end)
end

function ItemCellUI:onLoadComplete()
    self.number = self.uiTransform:Find("number"):GetComponent(typeof(CS.UnityEngine.UI.Text))
    self.number.text =  BagManager:getPropNum(self.itemID)
    self.selfBtn = self.uiTransform:GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.selfBtn.onClick:AddListener(function() self:selfBtnOnClick() end)
end

function ItemCellUI:onRefresh()
    if self.number then
        self.number.text =  BagManager:getPropNum(self.itemID)
    end
end

function ItemCellUI:selfBtnOnClick()
    UIManager:openUI(UIConst.UI_TYPE.PROP_DETAIL_UI, self.itemID)
end



return ItemCellUI