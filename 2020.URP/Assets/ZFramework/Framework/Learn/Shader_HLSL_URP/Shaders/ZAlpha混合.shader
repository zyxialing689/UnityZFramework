Shader "ZURP/ZAlpha混合"{
   Properties{
        _MainTex("MainTex",2D)="white"{}
        _AlphaTex("AlphaTex",2D)="white"{}
       }
   SubShader{
        Tags{
              "RenderPipeline"="UniversalPipeline"
              "RenderType"="Transparent"
//IgnoreProjector 标签
//如果提供了 IgnoreProjector 标签并且值为“True”，则使用此着色器的对象不会受到投影器的影响。这对半透明对象非常有用，因为投影器无法影响它们。
              "IgnoreProjector"="True"
//渲染顺序 - Queue 标签
//您可以使用 Queue 标签来确定对象的绘制顺序。着色器决定其对象属于哪个渲染队列，这样任何透明着色器都可以确保它们在所有不透明对象之后绘制，依此类推。
//有四个预定义的渲染队列，但预定义的渲染队列之间可以有更多的队列。预定义队列包括：
//Background 1000 - 此渲染队列在任何其他渲染队列之前渲染。通常会对需要处于背景中的对象使用此渲染队列。
//Geometry 2000（默认值）- 此队列用于大部分对象。不透明几何体使用此队列。
//AlphaTest 2450 - 进行 Alpha 测试的几何体将使用此队列。这是不同于 Geometry 队列的单独队列，因为在绘制完所有实体对象之后再渲染经过 Alpha 测试的对象会更有效。
//Transparent 3000 - 此渲染队列在 Geometry 和 AlphaTest 之后渲染，按照从后到前的顺序。任何经过 Alpha 混合者（即不写入深度缓冲区的着色器）都应该放在这里（玻璃、粒子效果）。
//Overlay - 此渲染队列旨在获得覆盖效果。最后渲染的任何内容都应该放在此处（例如，镜头光晕）。
//根据情况可以自定义如 "Queue"="1001" 或者 "Queue"="Background+1"            
              "Queue"="Transparent"
            }
        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        CBUFFER_START(UnityPerMaterial)
        float4 _MainTex_ST;
        float4 _AlphaTex_ST;
        CBUFFER_END
        TEXTURE2D(_MainTex);
        TEXTURE2D(_AlphaTex);
        SAMPLER(sampler_MainTex);
        SAMPLER(sampler_AlphaTex);

        struct inData
        {
            float3 positionOS:POSITION;
            float3 normalOS:NORMAL;
            float2 uv:TEXCOORD;
        };

        struct outData
        {
            float4 positionCS:SV_POSITION;
            float3 positionWS:TEXCOORD;
            float3 noramlWS:NORMAL;
            float4 uv:TEXCOORD1;
        };
        ENDHLSL
        Pass{
             
              HLSLPROGRAM
              #pragma vertex vert
              #pragma fragment frag

              outData vert(inData i){
               outData o;
               o.uv.xy = TRANSFORM_TEX(i.uv,_MainTex);
               o.uv.zw = TRANSFORM_TEX(i.uv,_AlphaTex);
               o.positionCS = TransformObjectToHClip(i.positionOS);

               
               return  o;    
            }
             float4 frag(outData o):SV_Target{

                 return float4(1,1,1,1);
             }
              
              ENDHLSL
           }
       }
}