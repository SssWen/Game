Shader "Custom/alphatest2" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MaskTex ("Base (RGB)", 2D) = "white" {}
		_Cutoff ("Cutoff Value", Range(0,1)) = 0.5
		_TransVal ("trans Value", Range(0,1)) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// 小于 _Cutoff的alpha值都被剔除掉，其他的保留
		#pragma surface surf Lambert alphatest:_Cutoff

		sampler2D _MainTex;
		sampler2D _MaskTex;
		float _TransValue;
		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// tex2D返回的rgba都是（0-1）的值
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half4 c2 = tex2D (_MaskTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c2.r;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
