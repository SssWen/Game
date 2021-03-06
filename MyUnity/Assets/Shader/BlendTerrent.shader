﻿Shader "Custom/BlendTerrent" {
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1)
		
		_ColorA ("Terrain Color A", Color) = (1,1,1,1)
		_ColorB ("Terrain Color B", Color) = (1,1,1,1)
		
		_RTexture ("Red Channel Texture", 2D) = ""{}
		_GTexture ("Green Channel Texture", 2D) = ""{}
		
		_BlendTexture ("Blend Channel Texture", 2D) = ""{}
	}
	
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _RTexture;
		sampler2D _GTexture;
		
		sampler2D _BlendTexture;
		
		float4 _MainTint;
		float4 _ColorA;
		float4 _ColorB;

		struct Input {
			float2 uv_RTexture;
			float2 uv_GTexture;
			
			float2 uv_BlendTexture;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			float4 blendData = tex2D(_BlendTexture, IN.uv_BlendTexture);
			
			float4 rTexData  = tex2D(_RTexture, IN.uv_RTexture);
			float4 gTexData  = tex2D(_GTexture, IN.uv_GTexture);
			
			float4 finalColor;
			finalColor = lerp(rTexData, gTexData, blendData.g);
			finalColor.a = 1.0;
			
			float4 terrainLayers = lerp(_ColorA, _ColorB, blendData.r);
			finalColor *= terrainLayers;
			finalColor = saturate(finalColor);
			
			o.Albedo = finalColor.rgb * _MainTint.rgb;
			o.Alpha = finalColor.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
































