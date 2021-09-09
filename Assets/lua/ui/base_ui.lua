local BaseUI=class("BaseUI")

----构造函数
function BaseUI:ctor(layerName,uiTransform)
    BaseUI.super.ctor(self)
    self._layerName = layerName
    self._uiTransform = uiTransform
end

----子类重写
function BaseUI:init() end

function BaseUI:registerEvent() end

function BaseUI:removeEvent() end

----注册子类
function BaseUI:registerUI(name)
    return self._uiTransform:Find(name)
end

----显示
function BaseUI:show()
    self._uiTransform.gameObject:SetActive(true)
    self._uiTransform:SetAsLastSibling() --设置最前
end

----隐藏
function BaseUI:hide( )
    self._uiTransform.gameObject:SetActive(false)
end

----关闭
function BaseUI:close()
    self:removeEvent()
    if self._uiTransform ~= nil then
        UnityEngine.GameObject.Destroy(self._uiTransform.gameObject)
    end
end

return BaseUI