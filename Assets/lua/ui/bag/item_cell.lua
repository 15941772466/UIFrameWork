local BagManager = require "module/bag/bag_manager"
local BagConst = require "data/bag/bag_const"
local ItemCell = class("ItemCell")

local BACK_BG = "Assets/res/common/box1.png"

function ItemCell:ctor(itemID)
    self.itemID = itemID
end

function ItemCell:getNode()
    return UIConst.UI_NODE.BAG
end

function ItemCell:getObjectResPath()
    return "Assets/res/prefabs/item_cell.prefab"
end

function ItemCell:getCellSpritePath()
    --补全的cell
    if not self.itemID then
        return BACK_BG
    end
    local item = BagManager:getItem(self.itemID)
    local spritePath = BagConst.QUALITY[item:getQuality()]
    return "Assets/res/common/"..spritePath
end

function ItemCell:getPropSpritePath()
    local item = BagManager:getItem(self.itemID)
    return item:getIcon()
end

function ItemCell:startLoad(index)
    local itemObjectPath = self:getObjectResPath()
    local spritePath = self:getCellSpritePath()
    UIManager:loadGameObject(itemObjectPath, function(gameObject)
        self.gameObject = gameObject
        --加载gameObject过程中 被关闭
        if self.deleted then
            self:delete()
            return
        end
        self.index = index
        if not UIManager.bagNode then
            UIManager.bagNode = UIManager.uiRoot.transform:Find(UIConst.UI_NODE.BAG)
            --说明背包关闭
            if not UIManager.bagNode then
                return
            end
        end
        self.gameObject.transform:SetParent(UIManager.bagNode.transform, false)
        self.uiTransform = gameObject.transform
        BagManager.cellTransformMap[index-1] = gameObject.transform
        self:setUIOrder(index-1)
        UIManager:loadSprite(spritePath, function(sprite)
            --加载cellSprite过程中 被关闭
            if self.deleted then
                return
            end
            self.cellSprite = sprite
            self:onLoadComplete()
            self:onRefresh()
        end)
    end)
end

function ItemCell:onLoadComplete()
    --根据类型添加底板
    self.cellImage = self.uiTransform:GetComponent(typeof(CS.UnityEngine.UI.Image))
    self.cellImage.sprite = self.cellSprite
    self.prop = self.uiTransform:Find("prop")
    --说明该道具被摧毁
    if not self.prop then
        return
    end
    --补全的cell
    if not self.itemID then
        self.prop.gameObject:SetActive(false)
        return
    end
    local propSpritePath = self:getPropSpritePath()
    UIManager:loadSprite(propSpritePath, function(sprite)
        --加载propSprite过程中 被关闭
        if self.deleted then
            return
        end
        self.propSprite = sprite
        --添加图标
        self.propImage = self.prop:GetComponent(typeof(CS.UnityEngine.UI.Image))
        self.propImage.sprite = self.propSprite
        self.number = self.uiTransform:Find("prop/number"):GetComponent(typeof(CS.UnityEngine.UI.Text))
        self.number.text = DataManager.bagData:getItemNum(self.itemID)
        self.selfBtn = self.prop:GetComponent(typeof(CS.UnityEngine.UI.Button))
        self.selfBtn.onClick:AddListener(function() self:selfBtnOnClick() end)
        self:onRefresh()
    end)
end

function ItemCell:setUIOrder(index)
    for i, v in pairs (BagManager.cellTransformMap) do
        if i >= index then
            v:SetSiblingIndex(i)
            for  i2, v2 in pairs (BagManager.cellTransformMap) do
                if i < i2 then
                    v2:SetSiblingIndex(i2)
                end
            end
        end
    end
end

function ItemCell:onRefresh()
    if self.number then
        self.number.text = DataManager.bagData:getItemNum(self.itemID)
    end
end

function ItemCell:delete()
    CS.UnityEngine.GameObject.Destroy(self.gameObject)
end

function ItemCell:selfBtnOnClick()
    UIManager:openUI(UIConst.UI_TYPE.PROP_DETAIL_UI, self.itemID)
end

return ItemCell