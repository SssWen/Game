Shader "Custom/NormalMap" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_NormalTex ("Normal RGB", 2D) = "bump" {}
		_NormalIntensity ("Normal Map Intensity", Range(0, 2)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _NormalTex;
		float _NormalIntensity;

		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			float3 normalMap = UnpackNormal(tex2D (_NormalTex, IN.uv_NormalTex));
			normalMap = float3(normalMap.x * _NormalIntensity, normalMap.y * _NormalIntensity, normalMap.z);
			o.Normal = normalMap.rgb;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
