Main = {}
CSMain = CS.DH.Main.Instance

function Main:init()
    self:initCS()
    self:initLua()
end

function Main:initCS()
    CSMain:SetLuaUpdateCallback(function()
        self:update()
    end)

    CSMain:SetLuaLateUpdateCallback(function()
        self:lateUpdate()
    end)
end

function Main:update()
end

function Main:lateUpdate()
end

function Main:initLua()
    self:disableGlobal()

    DH.Logger = require "common/logger"
    DH.UIManager = require "ui/ui_manager"
    DH.BaseUI = require "ui/base_ui"
end

---- 禁用全局变量
function Main:disableGlobal()
    local __g = _G
    DH = DH or {}
    setmetatable(DH, {
        __newindex = function(_, name, value)
            rawset(__g, name, value)
        end,

        __index = function(_, name)
            return rawget(__g, name)
        end
    })

    setmetatable(__g, {
        __newindex = function(_, name, value)
            print("new index, name is :", name)
            error(string.format("USE \" DH.%s = value \" INSTEAD OF SET GLOBAL VARIABLE", name), 0)
        end
    })
end

---- lua模拟类
class = function(className, supper)

end

Main:init()