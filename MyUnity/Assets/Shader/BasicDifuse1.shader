Shader "Custom/BasicDifuse1" {
	Properties {
		//_MainTex ("Base (RGB)", 2D) = "white" {}
		// 变量名字 （GUI中显示的名字， 变量类型） = （默认值）
		_EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
		_AmbientColor ("Ambient Color", Color) = (1,1,1,1)
		_MySliderValue ("This is a Slider", Range(0, 10)) = 2.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _MySliderValue;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			float4 c;
			c = pow((_EmissiveColor + _AmbientColor), _MySliderValue);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}




































