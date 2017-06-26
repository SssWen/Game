using UnityEngine;
using System.Collections;
using LuaInterface;
using System;
using System.IO;

public class testlua : MonoBehaviour {

	LuaState lua = null;
	// Use this for initialization
	void Start () {
		
		lua = new LuaState();                
		lua.Start();
		string fullPath = Application.dataPath + "\\LuaFramework\\";
		lua.AddSearchPath(fullPath);
		lua.DoFile("testlua.lua");
		lua.Collect();
		lua.CheckTop();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	void OnApplicationQuit()
	{
		lua.Dispose();
		lua = null;
	}
}
