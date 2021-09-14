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
    DH.UIConst = require "ui/ui_const"
    DH.EventSystem = require "ui/event_system"

    UIManager:init()
end

function Main:initForIdea()
    Logger = Logger or require "common/logger"
    UIManager =  UIManager or require "ui/ui_manager"
    BaseUI = BaseUI or require "ui/base_ui"
    UIConst = UIConst or require "ui/ui_const"
    EventSystem = EventSystem or require "ui/event_system"
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
class = function(className, super)
    local cls = {cname = className}

    if super then
        local superType = type(super)
        local msg = string.format("class() - create class \"%s\" with invalid super class type \"%s\"", className, superType)
        assert(superType == "table", msg)
        cls.super = super
        setmetatable(cls, {__index = super})
    end

    cls.ctor = function() end
    cls.new = function(_, ...)
        local instance = {}
        setmetatable(instance, {__index = cls})
        instance.class = cls
        if instance.super then
            local _constructor
            _constructor = function(c, ...)
                if c.super then
                    _constructor(c.super, ...)
                end
                c.ctor(instance, ...)
            end
            _constructor(instance.super, ...)
        end
        instance:ctor(...)
        return instance
    end
    cls.create = cls.new
    return cls
end

Main:init()