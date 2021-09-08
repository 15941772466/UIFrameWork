using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using XLua;

public class LuaCallCSharp : MonoBehaviour
{
    LuaEnv luaEnv = null; 
    void Start()
    {
        luaEnv = new LuaEnv();
        luaEnv.AddLoader(CustomMyLoader);
        luaEnv.DoString("require'LuaCallCSharp'");
    }

    //自定义lua读取文件路径
    private byte[] CustomMyLoader(ref string fileName)  
    {
        byte[] byteReturnByLua = null;

        string luaPath = Application.dataPath + "/Scripts/LuaScripts/" + fileName + ".lua";

        string luaContent = File.ReadAllText(luaPath);

        byteReturnByLua = System.Text.Encoding.UTF8.GetBytes(luaContent);

        return byteReturnByLua;
    }

    private void OnDestroy()
    {
        luaEnv.Dispose();
    }

}
