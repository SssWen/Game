Shader "Custom/NotVisibleColor" {
    Properties {
        _NotVisibleColor ("NotVisibleColor (RGB)", Color) = (0.3,0.3,0.3,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    SubShader {
        Tags { "Queue" = "Geometry+500" "RenderType"="Opaque" }
        LOD 200

        Pass {
      		// 设置zwrite的规则，当z大于该像素的时候执行下面规则
            ZTest Greater
            // 当上面规则成立时不将像素写入缓冲区
            ZWrite Off
            // 这边设置写入像素的混合模式
            Blend SrcAlpha OneMinusSrcAlpha
            // 设置纹理, 如何应用纹理被写在下面的两个{}中
            SetTexture [_MainTex] { ConstantColor [_NotVisibleColor] combine constant * texture}
        }

        Pass {
            ZTest LEqual
            Material {
                Diffuse (1,1,1,1)
                Ambient (1,1,1,1)
            }
            Lighting On
            SetTexture [_MainTex] { combine texture } 
        }

    } 
    FallBack "Diffuse"
}