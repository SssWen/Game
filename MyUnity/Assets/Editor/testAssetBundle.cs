using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class testAssetBundle : MonoBehaviour {

	[@MenuItem("Asset/BuildBundles")]
	static void BuildBundles() {

		string targetPath = Application.streamingAssetsPath;
		AssetBundleBuild[] buildmap = new AssetBundleBuild[2];
		buildmap[0].assetBundleName = "aa";
		string[] resourcesAssets = new string[2];

		resourcesAssets[0] = "Assets/Resources/Quad.prefab";
		resourcesAssets[1] = "Assets/Resources/aa.txt";
		buildmap [0].assetNames = resourcesAssets;
		BuildPipeline.BuildAssetBundles(targetPath, buildmap, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows);
	}

	[MenuItem ("Asset/Build AssetBundles")]
	static void BuildAllAssetBundles ()
	{
		string targetPath = Application.streamingAssetsPath;
		BuildPipeline.BuildAssetBundles (targetPath, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows);
	}
}
