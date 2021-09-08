using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using XLua;

public static class LuaGenConfig
{
    //lua中要使用到C#库的配置，比如C#标准库，或者Unity API，第三方库等。
    [LuaCallCSharp]
    public static List<Type> LuaCallCSharp = new List<Type>()
    {
        typeof(System.Object),
        typeof(UnityEngine.Object),
        typeof(Vector2),
        typeof(Vector3),
        typeof(Vector4),
        typeof(Quaternion),
        typeof(Color),
        typeof(Ray),
        typeof(Bounds),
        typeof(Ray2D),
        typeof(Time),
        typeof(GameObject),
        typeof(Component),
        typeof(Behaviour),
        typeof(Transform),
        typeof(Resources),
        typeof(TextAsset),
        typeof(Keyframe),
        typeof(AnimationCurve),
        typeof(AnimationClip),
        typeof(MonoBehaviour),
        typeof(ParticleSystem),
        typeof(SkinnedMeshRenderer),
        typeof(Renderer),
        typeof(Light),
        typeof(Mathf),
        typeof(List<int>),
        typeof(Action<string>),
        typeof(Debug),
    };
    

    //C#静态调用Lua的配置（包括事件的原型），仅可以配delegate，interface
    [CSharpCallLua]
    public static List<Type> CSharpCallLua = new List<Type>()
    {
        typeof(Action),
        typeof(Func<double, double, double>),
        typeof(Action<string>),
        typeof(Action<double>),
        typeof(UnityEngine.Events.UnityAction),
        typeof(IEnumerator)
    };

    //黑名单
    [BlackList]
    public static List<List<string>> BlackList = new List<List<string>>()
    {

    };
}
