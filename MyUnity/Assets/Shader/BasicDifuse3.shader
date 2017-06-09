Shader "Custom/BasicDifuse3" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		// 变量名字 （GUI中显示的名字， 变量类型） = （默认值）
		_EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
		_AmbientColor ("Ambient Color", Color) = (1,1,1,1)
		_MySliderValue ("This is a Slider", Range(0, 10)) = 2.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface  surf BasicDiffuse

		sampler2D _MainTex;
		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _MySliderValue;

		struct Input {
			float2 uv_MainTex;
		};
		
		inline float4 LightingBasicDiffuse(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			// dot 是点积函数用它来比较两个向量在空间里的方向。点积函数会检查两个向量是互相平行还是互相垂直。
			// 任意两个向量都可以通过点积函数来获得-1～1的夹角范围， -1表示平行向量并背离你的方向， 1也表示平行向量，不过不是朝向你的方向，
			// 0表示和你垂直的方向向量。两个向量之间的夹角越小，点积越大，表面可以接受的入射光也越多。
			float difLight = max(0, dot(s.Normal, lightDir));
			float hLambert = difLight * 0.5 + 0.5;
			float3 ramp = tex2D(_MainTex, float2(hLambert, hLambert)).rgb;
			
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			col.a = s.Alpha;
			return col;
		}

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




































