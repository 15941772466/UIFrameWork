print("LuaCallCSharp")

CSU = CS.UnityEngine
GameObject = CSU.GameObject

--new 一个GameObject实例
local newGo = CS.UnityEngine.GameObject()
newGo.name = "GameObject NewByLua"

--调用静态方法
local txt = GameObject.Find("Text"):GetComponent("UnityEngine.UI.Text")
txt.text = "Hello"

--访问C#成员属性，方法
local hero = CS.XLuaSys.Hero
local superman = hero()  --自动调用父类与子类的构造函数

superman:HeroAttack()    --调用自身成员方法   superman.HeroAttack(superman)
print(superman.name)     --调用自身字段

superman:CharacterChange()--调用父类成员方法
print(superman.type)     --调用父类字段

--方法重载
superman:MethodOverLoad(1.1,1.1)
superman:MethodOverLoad("ok","字符串重载成功")

--调用params关键字的方法
local paramsResult=superman:MethodParams(20,"character","hero","ok")
print(paramsResult)

--调用C#中带有结构体参数的方法
local heroStruct= {name="弓箭手",level="5星"}
superman:MethodStruct(heroStruct)

--调用C#中带有接口参数的方法
local heroInterface=
{
    name="炮兵",
    level="6星",

    LevelUp=function()
        print("lua：炮兵升级!")
    end
}
superman:MethodInterface(heroInterface)

--调用C#中带有委托参数的方法
local heroDelegate=function(level)
    print("委托：赋给英雄"..level)
end
superman:MethodDelegate(heroDelegate)

--调用c#中多返回值的函数
local name = "机枪射手"
local level = "满星"
local thisHero,name,level =superman:MethodMultiReturn(name,level)
print(thisHero)
print(name)
print(level)

--调用c#中有泛型参数的的方法
local heroes={"弓箭手","炮兵","机枪手"}
superman:MethodGeneric(heroes)

--调用c#中有自定义泛型参数的的方法
superman:Method_GenericBySelf()
--local newHero = CS.XLuaSys.GenericBySelf:GetHeroInfo<string>("召唤师")  --无法直接调用泛型

--调用C#中的“扩展方法”
superman:Method_Extension_GenericBySelf()