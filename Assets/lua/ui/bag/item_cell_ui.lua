local ItemCellUI = class("ItemCellUI")

local BagManager = require "module/bag/bag_manager"

function ItemCellUI:ctor(itemID)
    self.itemID = itemID
end

function ItemCellUI:getNode()
    return UIConst.UI_NODE.BAG
end

function ItemCellUI:getObjectResPath()
    return "Assets/res/prefabs/item_cell_ui.prefab"
end

function ItemCellUI:getCellSpritePath()
    --补全的cell
    if not self.itemID then
        return "Assets/res/common/box1.png"
    end

    local spritePath
    local item = BagManager:getItem(self.itemID)
    if item:getQuality() == 1 then
        spritePath = "box1.png"
    elseif item:getQuality() == 2 then
        spritePath = "box2.png"
    elseif item:getQuality() == 3 then
        spritePath = "box3.png"
    end
    return "Assets/res/common/"..spritePath
end

function ItemCellUI:getPropSpritePath()
    local item = BagManager:getItem(self.itemID)
    return "Assets/res/item/"..item:getIcon()
end

function ItemCellUI:startLoad()
    local itemObjectPath = self:getObjectResPath()
    local spritePath = self:getCellSpritePath()
    UIManager:loadGameObject(itemObjectPath, function(gameObject)
        self.gameObject = gameObject
        self.uiNode = self:getNode()
        if not UIManager.bagNode then
            UIManager.bagNode = UIManager.uiRoot.transform:Find(UIConst.UI_NODE.BAG)
        end
        self.gameObject.transform:SetParent(UIManager.bagNode.transform, false)
        self.uiTransform = gameObject.transform
        --BagManager.uiTransformMap[index] = gameObject.transform
        UIManager:loadSprite(spritePath, function(sprite)
            self.cellSprite = sprite
            self:onLoadComplete()
            self:onRefresh()
        end)
    end)
end

function ItemCellUI:onLoadComplete()
    --根据类型添加底板
    self.cellImage = self.uiTransform:GetComponent(typeof(CS.UnityEngine.UI.Image))
    self.cellImage.sprite = self.cellSprite
    self.prop = self.uiTransform:Find("prop")
    --补全的cell
    if not self.itemID then
        self.prop.gameObject:SetActive(false)
        return
    end
    local propSpritePath = self:getPropSpritePath()
    UIManager:loadSprite(propSpritePath, function(sprite)
        self.propSprite = sprite
        --添加图标
        self.propImage = self.prop:GetComponent(typeof(CS.UnityEngine.UI.Image))
        self.propImage.sprite = self.propSprite

        self.number = self.uiTransform:Find("prop/number"):GetComponent(typeof(CS.UnityEngine.UI.Text))
        self.number.text = BagManager:getPropNum(self.itemID)
        self.selfBtn = self.prop:GetComponent(typeof(CS.UnityEngine.UI.Button))
        self.selfBtn.onClick:AddListener(function() self:selfBtnOnClick() end)
        self:onRefresh()
    end)
end

function ItemCellUI:onRefresh()
    if self.number then
        self.number.text = BagManager:getPropNum(self.itemID)
    end
end

function ItemCellUI:selfBtnOnClick()
    UIManager:openUI(UIConst.UI_TYPE.PROP_DETAIL_UI, self.itemID)
end

return ItemCellUI