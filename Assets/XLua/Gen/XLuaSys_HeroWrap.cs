#if USE_UNI_LUA
using LuaAPI = UniLua.Lua;
using RealStatePtr = UniLua.ILuaState;
using LuaCSFunction = UniLua.CSharpFunctionDelegate;
#else
using LuaAPI = XLua.LuaDLL.Lua;
using RealStatePtr = System.IntPtr;
using LuaCSFunction = XLua.LuaDLL.lua_CSFunction;
#endif

using XLua;
using System.Collections.Generic;


namespace XLua.CSObjectWrap
{
    using Utils = XLua.Utils;
    public class XLuaSysHeroWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(XLuaSys.Hero);
			Utils.BeginObjectRegister(type, L, translator, 0, 10, 1, 1);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "HeroAttack", _m_HeroAttack);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "MethodOverLoad", _m_MethodOverLoad);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "MethodParams", _m_MethodParams);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "MethodStruct", _m_MethodStruct);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "MethodInterface", _m_MethodInterface);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "MethodDelegate", _m_MethodDelegate);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "MethodMultiReturn", _m_MethodMultiReturn);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "MethodGeneric", _m_MethodGeneric);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Method_GenericBySelf", _m_Method_GenericBySelf);
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "Method_Extension_GenericBySelf", _m_Method_Extension_GenericBySelf);
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "name", _g_get_name);
            
			Utils.RegisterFunc(L, Utils.SETTER_IDX, "name", _s_set_name);
            
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 1, 0, 0);
			
			
            
			
			
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					var gen_ret = new XLuaSys.Hero();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to XLuaSys.Hero constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_HeroAttack(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.HeroAttack(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_MethodOverLoad(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
			    int gen_param_count = LuaAPI.lua_gettop(L);
            
                if(gen_param_count == 3&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 2)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)) 
                {
                    float _num1 = (float)LuaAPI.lua_tonumber(L, 2);
                    float _num2 = (float)LuaAPI.lua_tonumber(L, 3);
                    
                    gen_to_be_invoked.MethodOverLoad( _num1, _num2 );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 2)&& LuaTypes.LUA_TNUMBER == LuaAPI.lua_type(L, 3)) 
                {
                    int _num1 = LuaAPI.xlua_tointeger(L, 2);
                    int _num2 = LuaAPI.xlua_tointeger(L, 3);
                    
                    gen_to_be_invoked.MethodOverLoad( _num1, _num2 );
                    
                    
                    
                    return 0;
                }
                if(gen_param_count == 3&& (LuaAPI.lua_isnil(L, 2) || LuaAPI.lua_type(L, 2) == LuaTypes.LUA_TSTRING)&& (LuaAPI.lua_isnil(L, 3) || LuaAPI.lua_type(L, 3) == LuaTypes.LUA_TSTRING)) 
                {
                    string _str1 = LuaAPI.lua_tostring(L, 2);
                    string _str2 = LuaAPI.lua_tostring(L, 3);
                    
                    gen_to_be_invoked.MethodOverLoad( _str1, _str2 );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
            return LuaAPI.luaL_error(L, "invalid arguments to XLuaSys.Hero.MethodOverLoad!");
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_MethodParams(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    int _num1 = LuaAPI.xlua_tointeger(L, 2);
                    string[] _strArray = translator.GetParams<string>(L, 3);
                    
                        var gen_ret = gen_to_be_invoked.MethodParams( _num1, _strArray );
                        LuaAPI.xlua_pushinteger(L, gen_ret);
                    
                    
                    
                    return 1;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_MethodStruct(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    XLuaSys.HeroStruct _hero;translator.Get(L, 2, out _hero);
                    
                    gen_to_be_invoked.MethodStruct( _hero );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_MethodInterface(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    XLuaSys.HeroInterface _hero = (XLuaSys.HeroInterface)translator.GetObject(L, 2, typeof(XLuaSys.HeroInterface));
                    
                    gen_to_be_invoked.MethodInterface( _hero );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_MethodDelegate(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    XLuaSys.HeroDelegate _hero = translator.GetDelegate<XLuaSys.HeroDelegate>(L, 2);
                    
                    gen_to_be_invoked.MethodDelegate( _hero );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_MethodMultiReturn(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    string _name = LuaAPI.lua_tostring(L, 2);
                    string _level;
                    
                        var gen_ret = gen_to_be_invoked.MethodMultiReturn( ref _name, out _level );
                        LuaAPI.lua_pushstring(L, gen_ret);
                    LuaAPI.lua_pushstring(L, _name);
                        
                    LuaAPI.lua_pushstring(L, _level);
                        
                    
                    
                    
                    return 3;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_MethodGeneric(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    System.Collections.Generic.List<string> _heroArray = (System.Collections.Generic.List<string>)translator.GetObject(L, 2, typeof(System.Collections.Generic.List<string>));
                    
                    gen_to_be_invoked.MethodGeneric( _heroArray );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Method_GenericBySelf(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.Method_GenericBySelf(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_Method_Extension_GenericBySelf(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.Method_Extension_GenericBySelf(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_name(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.name);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_name(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                XLuaSys.Hero gen_to_be_invoked = (XLuaSys.Hero)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.name = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
		
		
		
		
    }
}
