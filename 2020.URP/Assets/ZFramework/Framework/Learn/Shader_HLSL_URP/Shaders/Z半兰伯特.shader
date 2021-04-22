Shader "ZURP/Z半兰伯特"
{
    Properties
    {
		_BaseColor("BaseColor",color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags
		 {
			"RenderType" = "Opaque"
			"RenderPipeline" = "UniversalRenderPipeline"
		 }

		HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
		CBUFFER_START(UnityPerMaterial)
		float4 _BaseColor;
	    float4 _MainTex_ST;
		CBUFFER_END

			TEXTURE2D(_MainTex);
		    SAMPLER(sampler_MainTex);

		ENDHLSL

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            struct appdata
            {
                float4 position : POSITION;
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 normalWS:TEXCOORD1;
                float4 position : SV_POSITION;
            };


            v2f vert (appdata v)
            {
				v2f o;
                o.normalWS = TransformObjectToWorldNormal(v.normal.xyz);
				o.position = TransformObjectToHClip(v.position.xyz);
				o.uv = TRANSFORM_TEX(v.uv,_MainTex);
				return o;
            }

            real4 frag (v2f i) : SV_Target//real 新的数据结构，用于平台差异
            {
			  real4 col = SAMPLE_TEXTURE2D(_MainTex,sampler_MainTex,i.uv)*_BaseColor;
              Light mainLight = GetMainLight();//主光源
              half3 direction = mainLight.direction;//光方向
              half3 diffuse = max(0,dot(direction,i.normalWS))*0.5+0.5;
            
			  return real4(diffuse*col.xyz,1);
            }
		    ENDHLSL
        }
    }
}
