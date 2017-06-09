Shader "Custom/SpecShader" {
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_SpecularColor ("Specular Tint", Color) = (1,1,1,1)
		_SpecularMask ("Specular Texture", 2D) = "white" {}
		_SpecPower ("Specular Power", Range(0.1, 120)) = 3
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf CustomPhong

		sampler2D _MainTex;
		sampler2D _SpecularMask;
		float4 _MainTint;
		float4 _SpecularColor;
		float _SpecPower;
		
		struct SurfaceCustomOutput
		{
			fixed3 Albedo;
			fixed3 Normal;
			fixed3 Emission;
			fixed3 SpecularColor;  // 它使我们能够从高光颜色纹理中存储各个像素的信息，并且将它们应用到我们的光照函数中，而不是仅仅在高光值上乘以一个单一的全局颜色值
			half Specular;
			fixed Gloss;
			fixed Alpha;
		};

		struct Input {
			float2 uv_MainTex;
			float2 uv_SpecularMask;
		};
		
		inline fixed4 LightingCustomPhong(SurfaceCustomOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			// 首先会计算顶点法线和光的入射方向或矢量的点积来声明一个常用的漫反射组件，
			// 返回值为1时，表示物体是正对着光源的方向，反之该值为-1是表示物体是背对者光源方向
			float diff = dot(s.Normal, lightDir);
			// 计算反射向量，该值乘以2.0后再乘以diff值，得到的值减去光照方向，这样做的目的是为了实现法线朝向光源弯曲的效果，所以作为一个远离光源的法线向量
			// 它被强制朝向了光源方向
			float3 reflectionVector = normalize(2.0 * s.Normal * diff - lightDir);
			// 创建spec值和颜色值，为了得到这个值，我们对反射向量和视角方向进行点积运算，然后对结果求_SpecPower次方，
			// 最后将_SpecularColor.rgb值乘以spec值得到我们最后的高光
			float spec = pow(max(0.0f, dot(reflectionVector, viewDir)), _SpecPower) * s.Specular;
			float finalSpec = s.SpecularColor * spec * _SpecularColor.rgb;
			
			fixed4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * diff) + (_LightColor0.rgb * finalSpec);
			c.a = s.Alpha;
			return c;
		}

		void surf (Input IN, inout SurfaceCustomOutput o) {
			// 主纹理 × 色调
			float4 c = tex2D(_MainTex, IN.uv_MainTex) * _MainTint;
			// 镜面掩码 ×　镜面颜色
			float4 specMask = tex2D(_SpecularMask, IN.uv_SpecularMask);
			
			o.Albedo = c.rgb;
			o.Specular = specMask.r;
			o.SpecularColor = specMask.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}






































