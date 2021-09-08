using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace XLuaSys
{
    public class Character 
    {
        public string type = "some character";

        public Character()
        {
            Debug.Log("character构造方法");
        }

        public void CharacterChange()
        {
            Debug.Log("角色改变了");
        }
    }
}

