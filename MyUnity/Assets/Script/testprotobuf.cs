using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using protos.login;

public class testprotobuf : MonoBehaviour {

	// Use this for initialization
	void Start () {
		ReqLogin aa = new ReqLogin();
		aa.password = "1234";
		aa.account = "lxb";
		byte[] myByte = Comman.Serialize<ReqLogin> (aa);
		ReqLogin bb = Comman.DeSerialize<ReqLogin> (myByte);
		Debug.Log (bb.account);
		Debug.Log (bb.password);
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
