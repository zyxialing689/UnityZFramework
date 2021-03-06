// 这个shader给mesh填充一个固定的颜色
Shader "ZURP/0_5Z多pass渲染"
{
	// shader的属性，这个例子里面是空的，就代表没有对外暴露的属性
	Properties{}

		// SubShader块包含Shader代码
		SubShader
	{
		// Tags定义了subshader块何时以及在什么条件下执行
        //RenderType以及它的数值就是一种约定，因为它自带的shader全部使用这些数值，所以我们依照他的习惯这样使用会方便很多，否则需要自己完全定义一套。当然如果不使用替代渲染，就可以完全忽略这个参数。
		Tags
		{
			"RenderType" = "Opaque"
		}

		Pass
		{
			Tags
			{
				"LightMode" = "UniversalForward"
			}

		// HLSL代码块，Unity SRP使用HLSL语言
		HLSLPROGRAM
		// 定义顶点shader的名字
		#pragma vertex vert
		// 定义片元shader的名字
		#pragma fragment frag

		// 这个Core.hlsl文件包含了常用的HLSL宏定义以及函数，也包括了对其他常用HLSL文件的引用
		// 例如Common.hlsl, SpaceTransforms.hlsl等
		#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

		// 下面结构体包含了顶点着色器的输入数据
		struct Attributes
		{
			float4 positionOS   : POSITION;
			// 声明需要法线数据
			half3 normal        : NORMAL;
		};

		struct Varyings
		{
			// 这个结构体里必须包含SV_POSITION, Homogeneous Clipping Space
			float4 positionHCS : SV_POSITION;
			// 用于存储法线的数据
			half3 normal : TEXCOORD0;
		};
		CBUFFER_START(UnityPerMaterial)
		CBUFFER_END

			// 顶点着色器
			Varyings vert(Attributes IN)
			{
			// 定义输出的结构体
			Varyings OUT;
			// TransformObjectToHClip函数可以将顶点位置从物体空间转换到齐次裁剪空间
			OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
			// 计算法线到世界坐标系
			OUT.normal = TransformObjectToWorldNormal(IN.normal);
			

			return OUT;
		}

		// 片元着色器        
		half4 frag(Varyings IN) : SV_Target
		{
			half4 color = 0;
			color.rgb = IN.normal * 0.5 + 0.5;
			clip(color.r - 0.75);//clip函数会将参数小于0的像素点直接丢弃掉

			return color;
		}
		ENDHLSL
	}
	Pass
	{
		Tags
		{
			"LightMode" = "UniversalForwardOnly"
		}

			// HLSL代码块，Unity SRP使用HLSL语言
			HLSLPROGRAM
			// 定义顶点shader的名字
			#pragma vertex vert
			// 定义片元shader的名字
			#pragma fragment frag

			// 这个Core.hlsl文件包含了常用的HLSL宏定义以及函数，也包括了对其他常用HLSL文件的引用
			// 例如Common.hlsl, SpaceTransforms.hlsl等
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

			// 下面结构体包含了顶点着色器的输入数据
			struct Attributes
			{
				float4 positionOS   : POSITION;
				// 声明需要法线数据
				half3 normal        : NORMAL;
			};

			struct Varyings
			{
				// 这个结构体里必须包含SV_POSITION, Homogeneous Clipping Space
				float4 positionHCS : SV_POSITION;
				// 用于存储法线的数据
				half3 normal : TEXCOORD0;
			};

			CBUFFER_START(UnityPerMaterial)
			CBUFFER_END

				// 顶点着色器
				Varyings vert(Attributes IN)
				{
				// 定义输出的结构体
				Varyings OUT;
				// TransformObjectToHClip函数可以将顶点位置从物体空间转换到齐次裁剪空间
				OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
				// 计算法线到世界坐标系
				OUT.normal = TransformObjectToWorldNormal(IN.normal);

				return OUT;
			}

			// 片元着色器        
			half4 frag(Varyings IN) : SV_Target
			{
				half4 color = 0;
				color.rgb = IN.normal * 0.5 + 0.5;
				 clip(0.5 - color.r);
				 clip(color.r - 0.25);

				return color;
			}
			ENDHLSL
		}

		Pass
		{
			Tags
			{
				"LightMode" = "LightweightForward"
			}

				// HLSL代码块，Unity SRP使用HLSL语言
				HLSLPROGRAM
				// 定义顶点shader的名字
				#pragma vertex vert
				// 定义片元shader的名字
				#pragma fragment frag

				// 这个Core.hlsl文件包含了常用的HLSL宏定义以及函数，也包括了对其他常用HLSL文件的引用
				// 例如Common.hlsl, SpaceTransforms.hlsl等
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

				// 下面结构体包含了顶点着色器的输入数据
				struct Attributes
				{
					float4 positionOS   : POSITION;
					// 声明需要法线数据
					half3 normal        : NORMAL;
				};

				struct Varyings
				{
					// 这个结构体里必须包含SV_POSITION, Homogeneous Clipping Space
					float4 positionHCS : SV_POSITION;
					// 用于存储法线的数据
					half3 normal : TEXCOORD0;
				};

				CBUFFER_START(UnityPerMaterial)
				CBUFFER_END

					// 顶点着色器
					Varyings vert(Attributes IN)
					{
					// 定义输出的结构体
					Varyings OUT;
					// TransformObjectToHClip函数可以将顶点位置从物体空间转换到齐次裁剪空间
					OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
					// 计算法线到世界坐标系
					OUT.normal = TransformObjectToWorldNormal(IN.normal);

					return OUT;
				}

				// 片元着色器        
				half4 frag(Varyings IN) : SV_Target
				{
					half4 color = 0;
					color.rgb = IN.normal * 0.5 + 0.5;
					 clip(0.75 - color.r);
					 clip(color.r - 0.5);

					return color;
				}
				ENDHLSL
			}

			Pass
			{
				Tags
				{
					"LightMode" = "SRPDefaultUnlit"
				}

					// HLSL代码块，Unity SRP使用HLSL语言
					HLSLPROGRAM
					// 定义顶点shader的名字
					#pragma vertex vert
					// 定义片元shader的名字
					#pragma fragment frag

					// 这个Core.hlsl文件包含了常用的HLSL宏定义以及函数，也包括了对其他常用HLSL文件的引用
					// 例如Common.hlsl, SpaceTransforms.hlsl等
					#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

					// 下面结构体包含了顶点着色器的输入数据
					struct Attributes
					{
						float4 positionOS   : POSITION;
						// 声明需要法线数据
						half3 normal        : NORMAL;
					};

					struct Varyings
					{
						// 这个结构体里必须包含SV_POSITION, Homogeneous Clipping Space
						float4 positionHCS : SV_POSITION;
						// 用于存储法线的数据
						half3 normal : TEXCOORD0;
					};

					CBUFFER_START(UnityPerMaterial)
					CBUFFER_END

						// 顶点着色器
						Varyings vert(Attributes IN)
						{
						// 定义输出的结构体
						Varyings OUT;
						// TransformObjectToHClip函数可以将顶点位置从物体空间转换到齐次裁剪空间
						OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
						// 计算法线到世界坐标系
						OUT.normal = TransformObjectToWorldNormal(IN.normal);

						return OUT;
					}

					// 片元着色器        
					half4 frag(Varyings IN) : SV_Target
					{
						half4 color = 0;
						color.rgb = IN.normal * 0.5 + 0.5;
						 clip(0.25 - color.r);

						return color;
					}
					ENDHLSL
				}
	}
}