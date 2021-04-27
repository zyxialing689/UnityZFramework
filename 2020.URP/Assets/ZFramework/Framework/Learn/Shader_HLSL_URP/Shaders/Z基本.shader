Shader "ZURP/Z基本"{
	//Properites 所支持的数据类型
	Properties{
		_int("int",int) = 1
		_float("float",float) = 1.5
		_range("range",Range(0,5)) = 3
		_color("color",Color) = (1,1,1,1)
		_vector("Vector",Vector) = (2,3,6,1)
		_2d("2d",2D) = "white"{}
	    _cube("cube",Cube) = "white"{}
		_3d("3d",3D) = "black"{}
		}
			SubShader
			{	
		    Tags{			
		    	//该tag表示指定渲染管线渲染；1：就是当前渲染管线，则调用该subshader。
		    	//2：不是当前渲染管线，但只有这一个subshader，且该shader没有在当前渲染管线下报错，可以调用该subshader
			  	"RenderPipeline" = "UniversalPipeline"
				"RenderType" = "Opaque"
				}

				HLSLINCLUDE
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
				CBUFFER_START(UnityPerMaterial)
					float4 _2d_ST;
					float4 _color;
				CBUFFER_END
						TEXTURE2D(_2d);
						SAMPLER(sampler_2d);
					struct a2v {
					float4 position:POSITION;
					float4 normal:NORMAL;
					float2 uv : TEXCOORD;
			     	};
				    struct v2f {
						float4 position:SV_POSITION;
						float2 uv:TEXCOORD;
					};

			    ENDHLSL
				pass {
					HLSLPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					v2f vert(a2v i) {
						v2f o;
						o.position = TransformObjectToHClip(i.position.xyz);
						o.uv = TRANSFORM_TEX(i.uv, _2d);
						return o;
					}
					half4 frag(v2f i) :SV_TARGET{
						half4 col = SAMPLE_TEXTURE2D(_2d,sampler_2d,i.uv)*_color;
						return col;
					}
					ENDHLSL
				}
		}
}