using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.IO;
using XLua;
using UnityEngine.UI;

namespace DH
{
    public class Main : MonoBehaviour
    {
        struct Delay
        {
            public Action action;
            public int delayFrame; // 延迟帧数
        }

        public static Main Instance { get; private set; }

        LuaEnv luaEnv;

        Action luaUpdateCallback;
        Action luaLateUpdateCallback;

        System.Random random = new System.Random(999);
        List<Delay> delayList = new List<Delay>();

        void Start()
        {
            Instance = this;
            InitLua();
        }

        void InitLua()
        {
            luaEnv = new LuaEnv();
            luaEnv.AddLoader(CustomLoader);
            luaEnv.DoString("require 'main'");
        }

        byte[] CustomLoader(ref string fileName)
        {
            string luaPath = Application.dataPath + "/Lua/" + fileName + ".lua";
            string luaContent = File.ReadAllText(luaPath);
            return System.Text.Encoding.UTF8.GetBytes(luaContent);
        }

        void Update()
        {
            UpdateDelay();
            luaUpdateCallback?.Invoke();
        }

        void UpdateDelay()
        {
            for (int i = delayList.Count - 1; i >= 0; i--)
            {
                var delay = delayList[i];
                if (delay.delayFrame <= Time.frameCount)
                {
                    delay.action();
                    delayList.RemoveAt(i);
                }
            }
        }

        void LateUpdate()
        {
            luaLateUpdateCallback?.Invoke();
        }

        public void SetLuaUpdateCallback(Action callback)
        {
            luaUpdateCallback = callback;
        }

        public void SetLuaLateUpdateCallback(Action callback)
        {
            luaLateUpdateCallback = callback;
        }

        /// <summary>
        /// 加载资源
        /// </summary>
        /// <param name="assetPath">资源路径</param>
        /// <param name="type">资源类型</param>
        /// <param name="complete">加载完成回调</param>
        public void LoadAsset(string assetPath, Type type, Action<UnityEngine.Object> complete)
        {
#if UNITY_EDITOR
            var asset = UnityEditor.AssetDatabase.LoadAssetAtPath(assetPath, type);
            if (ReferenceEquals(asset, null))
            {
                throw new Exception(string.Format("加载资源为空:{0}", assetPath));
            }

            // editor下模拟异步加载情况
            int frame = random.Next(1, 5);
            AddDelay(frame, () =>
            {
                complete?.Invoke(asset);
            });
#endif
        }

        /// <summary>
        /// 添加一个延迟方法
        /// </summary>
        /// <param name="frame">延迟帧数</param>
        /// <param name="action">执行回调</param>
        public void AddDelay(int frame, Action action)
        {
            delayList.Add(new Delay
            {
                delayFrame = Time.frameCount + frame,
                action = action
            });
        }
    }
}