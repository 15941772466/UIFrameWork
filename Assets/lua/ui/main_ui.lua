local MainUI = class("BagUI", BaseUI)

MainUI.resPath = "Assets/res/prefabs/main_ui.prefab"

function MainUI:init()

end

function MainUI:registerEvent()

end

function MainUI:removeEvent()

end

function MainUI:getResPath()
    return self.resPath
end

function MainUI:onLoadComplete() end

return MainUI