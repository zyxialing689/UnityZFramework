Shader "ZURP/0_4Z映射采樣"{
	Properties{
		_RempTex("RempTex",2D)="white"{}
		}
	SubShader{
        Tags{
        	  "RenderPipeline"="UniversalPipeline"
        	  "RenderType"="Opaque"
        	}
		HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
		#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
		CBUFFER_START(UnityPerMaterial)
		float4 _RempTex_ST;
		CBUFFER_END
		TEXTURE2D(_RempTex);
	    SAMPLER(sampler_RempTex);

		struct inData
		{
			float3 positionOS :POSITION;
			float3 normalOS:NORMAL;
			float2 uv : TEXCOORD;
		};

		struct outData
		{
			float4 positionCS:SV_POSITION;
			float3 positionWS:TEXCOORD;
			float3 normalWS:NORMAL;
			float2 uv:TEXCOORD1;
		};
		ENDHLSL
		Pass{
			HLSLPROGRAM
			
			 #pragma vertex vert
			 #pragma fragment frag

			outData vert(inData i)
			{
			   outData o;
			   o.positionCS = TransformObjectToHClip(i.positionOS);
			   o.positionWS = TransformObjectToWorld(i.positionOS);
			   o.normalWS = TransformObjectToWorldNormal(i.normalOS);
			   o.uv = TRANSFORM_TEX(i.uv,_RempTex);
		     	return  o;
			}

			float4 frag(outData o):SV_Target{

                Light light = GetMainLight();
   				float3 diffuse = dot(light.direction,o.normalWS)*0.5+0.5;

				float4 col = SAMPLE_TEXTURE2D(_RempTex,sampler_RempTex,diffuse.xy);
				
				return col;
			}
			
			ENDHLSL
			 }

		}
		
}