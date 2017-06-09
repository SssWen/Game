Shader "Custom/uvMove" {
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_ScrollXSpeed ("X Speed", Range(0, 10)) = 2
		_ScrollYSpeed ("Y Speed", Range(0, 10)) = 2
		
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		float4 _MainTint;
		float _ScrollXSpeed;
		float _ScrollYSpeed;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed2 scrolledUV = IN.uv_MainTex;
			float x = _ScrollXSpeed * _Time;
			float y = _ScrollYSpeed * _Time;
			scrolledUV += fixed2(x, y);
			half4 c = tex2D(_MainTex, scrolledUV);
			o.Albedo = c.rgb * _MainTint;
			o.Alpha  = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}




























