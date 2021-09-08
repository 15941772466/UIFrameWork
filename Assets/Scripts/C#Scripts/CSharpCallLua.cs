using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;
using System.IO;
using System;

public class CSharpCallLua: MonoBehaviour
{
    LuaEnv env = null;
    public delegate void Add(int num1, int num2);
    [CSharpCallLua]
    public delegate void delAddingMutilReturnOut(int num1, int num2, out int res1, out int res2, out int res3);
    [CSharpCallLua]
    public delegate void delAddingMutilReturnRef(ref int num1, ref int num2, out int result);

    void Start()
    {
        env = new LuaEnv();
        //-------------------  三种加载lua方式  ---------------------------------------
        env.AddLoader(CustomMyLoader);
        env.DoString("require'CSharpCallLua'");

        //env.DoString("print('hello XLua')");

        //env.DoString("require'ResourcesRequire'");
        //TextAsset resourcesLua = Resources.Load<TextAsset>("ResourcesRequire.lua");
        //env.DoString(resourcesLua.text);


        //---------------------  访问全局变量  -------------------------------------------
        //int a = env.Global.Get<int>("a");
        //string b = env.Global.Get<string>("b");
        //string c = env.Global.Get<string>("c");
        //Debug.Log(a);
        //Debug.Log(b);
        //Debug.Log(c);


        //--------------  访问Table 映射到普通class或struct 值拷贝  -----------------------
        //GameName gameName = env.Global.Get<GameName>("gameName");
        //Debug.Log(gameName.name1);
        //Debug.Log(gameName.name2);
        //Debug.Log(gameName.name3);
        //gameName.name1 = "修改了吗？";

        //GameName gameNameChange = env.Global.Get<GameName>("gameName");
        //Debug.Log("修改了吗？  :" + gameNameChange.name1);


        //--------------  访问Table 映射到接口 引用拷贝  ----------------------------------
        //GameNames gameNames = env.Global.Get<GameNames>("gameName");
        //Debug.Log(gameNames.name1);
        //Debug.Log(gameNames.name2);
        //Debug.Log(gameNames.name3);
        //gameNames.name1 = "修改了吗？";
        //GameName gameNamesChange = env.Global.Get<GameName>("gameName");
        //Debug.Log("修改了吗？  :" + gameNamesChange.name1);


        //-------  更轻量级的by value方式：映射到Dictionary<>，List<>  --------------------
        //Dictionary<string, object> gameNameDic = env.Global.Get<Dictionary<string, object>>("gameName");
        //foreach (var item in gameNameDic)
        //{
        //    Debug.Log("gameName"+item.Key+": "+item.Value);
        //}

        //List<object> gameNameList = env.Global.Get<List<object>>("gameNames");
        //foreach (var item in gameNameList)
        //{
        //    Debug.Log("gameName: " + item );
        //}


        //-------------------  使用luaTable 方式进行映射  -------------------------------
        //XLua.LuaTable gameUser = env.Global.Get<XLua.LuaTable>("gameUser");

        //Debug.Log("name= " + gameUser.Get<string>("name"));
        //Debug.Log("Age= " + gameUser.Get<int>("age"));

        //XLua.LuaFunction Play = gameUser.Get<XLua.LuaFunction>("Play");
        //Play.Call();
        //XLua.LuaFunction Exit = gameUser.Get<XLua.LuaFunction>("Exit");
        //Exit.Call();


        //-----------------  使用“delegate ”来映射lua中的全局函数  ------------------------
        //Action act = null;
        //Add del = null;
        //delAddingMutilReturnOut delAddingMutilReturnOut = null;
        //delAddingMutilReturnRef delAddingMutilReturnRef = null;

        //act = env.Global.Get<Action>("ProcMyFunc1");
        //del = env.Global.Get<Add>("ProcMyFunc2");
        //delAddingMutilReturnOut = env.Global.Get<delAddingMutilReturnOut>("ProcMyFunc3");
        //delAddingMutilReturnRef = env.Global.Get<delAddingMutilReturnRef>("ProcMyFunc3");

        //act.Invoke();
        //del.Invoke(100,200);
        //int result1, result2, result3;
        //delAddingMutilReturnOut(1, 1, out result1, out result2, out result3);
        //Debug.Log("delAddingMutilReturnOut: "+result1 + "  " + result2 + "  " + result3);
        //delAddingMutilReturnRef(ref result1, ref result2, out result3);
        //Debug.Log("delAddingMutilReturnRef: " + result1 + "  " + result2 + "  " + result3);


        //----------------  使用“LuaFunction ”来映射lua中的全局函数  ----------------------
        //LuaFunction luaFun = env.Global.Get<LuaFunction>("ProcMyFunc1");
        //LuaFunction luaFun2 = env.Global.Get<LuaFunction>("ProcMyFunc2");
        //LuaFunction luaFun3 = env.Global.Get<LuaFunction>("ProcMyFunc3");
        //luaFun.Call();
        //luaFun2.Call(10, 20);
        //object[] objArray = luaFun3.Call(30, 40);
        //Debug.Log(string.Format("测试多返回数值 res1={0},res2={1},res3={2}", objArray[0], objArray[1], objArray[2]));
    }


    class GameName
    {
        public string name1;
        public string name2;
        public string name3;
    }

    [CSharpCallLua]
    public interface GameNames
    {
        string name1 { get; set; }
        string name2 { get; set; }
        string name3 { get; set; }
    }

    private byte[] CustomMyLoader(ref string fileName)  //自定义lua读取文件路径
    {
        byte[] byteReturnByLua = null;

        string luaPath = Application.dataPath + "/Scripts/LuaScripts/" + fileName + ".lua";

        string luaContent = File.ReadAllText(luaPath);

        byteReturnByLua = System.Text.Encoding.UTF8.GetBytes(luaContent);

        return byteReturnByLua;
    }

    private void OnDestroy()
    {
        //act = null;
        //del = null;
        //delAddingMutilReturnOut = null;
        //delAddingMutilReturnRef = null;
        env.Dispose();
    }
}


/*使用建议

1.访问lua全局数据，特别是table以及function，代价比较大，建议尽量少做，
比如在初始化时把要调用的lua function获取一次（映射到delegate）后，保存下来，后续直接调用该delegate即可。table也类似。

2.如果lua侧的实现的部分都以delegate和interface的方式提供，使用方可以完全和xLua解耦：
由一个专门的模块负责xlua的初始化以及delegate、interface的映射，然后把这些delegate和interface设置到要用到它们的地方。

*/