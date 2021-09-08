using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace XLuaSys
{
    [XLua.LuaCallCSharp]
    public class Hero : Character
    {
        public string name = "some hero";

        public Hero()
        {
            Debug.Log("hero 构造函数");
        }
        public void HeroAttack()
        {
            Debug.Log("英雄攻击了");
        }

        //方法重载  
        public void MethodOverLoad(float num1, float num2)
        {
            Debug.Log(GetType() + "/Method2()/ 重载方法/float浮点型/num1=" + num1 + " num2=" + num2);
        }

        public void MethodOverLoad(int num1, int num2)
        {
            Debug.Log(GetType() + "/Method2()/ 重载方法/int浮点型/num1=" + num1 + " num2=" + num2);
        }

        public void MethodOverLoad(string str1, string str2)
        {
            Debug.Log(GetType() + "/Method2()/ 重载方法/字符串类型/str1=" + str1 + " str2=" + str2);
        }

        //含可变参数的方法
        public int MethodParams(int num1, params string[] strArray)
        {
            foreach (string item in strArray)
            {
                Debug.Log("字符串内容：" + item);
            }
            return num1 ;
        }

        //有结构体参数的方法
        public void MethodStruct(HeroStruct hero)
        {
            Debug.Log("hero.name: " + hero.name);
            Debug.Log("hero.level: " + hero.level);
        }

        //有接口为参数的方法
        public void MethodInterface(HeroInterface hero)
        {
            Debug.Log(hero.name);
            Debug.Log(hero.level);
            hero.LevelUp();
        }

        //有委托为参数的方法
        public void MethodDelegate(HeroDelegate hero)
        {
            hero.Invoke("10星");
        }

        //有多返回数值的方法
        public string MethodMultiReturn(ref string name, out string level)
        {
            level = "99星";
            return name + level;
        }

        //有泛型方法为参数的方法
        public void MethodGeneric(List<string> heroArray)
        {
            foreach (string item in heroArray)
            {
                Debug.Log("泛型集合中的内容=" + item);
            }
        }

        //调用自定义泛型方法
        public void Method_GenericBySelf()
        {

            //测试字符串的比较
            string str = "魔法师";
            string heroInfo;

            GenericBySelf obj = new GenericBySelf();
            heroInfo = obj.GetHeroInfo<string>(str);
            Debug.Log("C#：新角色 " + heroInfo);
        }

        //调用扩展方法
        public void Method_Extension_GenericBySelf()
        {
            string hero = "召唤师";
            string heroInfo;
            GenericBySelf obj = new GenericBySelf();
            heroInfo = obj.GetHeroInfoExten(hero);
            Debug.Log("应用扩展方法: " + heroInfo);
        }
    }

    public struct HeroStruct
    {
        public string name;
        public string level;
    }

    [XLua.CSharpCallLua]
    public interface HeroInterface
    {
        string name { get; set; }
        string level { get; set; }
        void LevelUp();
    }

    [XLua.CSharpCallLua]
    public delegate void HeroDelegate(string level);

    [XLua.LuaCallCSharp]
    public class GenericBySelf
    {
        public T GetHeroInfo<T>(T info) 
        {  
            return info;
        }
    }

    [XLua.LuaCallCSharp]
    public static class Extension_GenericBySelf
    {
        public static string GetHeroInfoExten(this XLuaSys.GenericBySelf gen, string name)
        {
            return name;
        }
    }
}
