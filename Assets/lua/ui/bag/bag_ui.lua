local BagUI = class("BagUI", BaseUI)
BagUI.uiName = "bagUI"
BagUI.resPath = "Assets/res/prefabs/bag_ui.prefab"

function BagUI:init()

end

function BagUI:registerEvent()

end

function BagUI:removeEvent()

end

function BagUI:getResPath()
    return self.resPath
end

function BagUI:onLoadComplete() end

return BagUI