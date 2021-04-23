Shader "ZURP/Z半兰伯特+高光"
{
    Properties
    {
        _BaseColor("BaseColor",color) = (1,1,1,1)
        _MainTex("MainTex",2D) = "white"{}
        _SpecularRange("SpecularRange",Range(10,300)) = 10
        _SpecularColor("SpecualrColor",color) = (1,1,1,1)
    }

    SubShader
    {
       Tags
       {
         "RenderType" = "Qpaque"
//       "RenderPipeline" = "UniversalRenderPipeline"
       }
      LOD 300
       HLSLINCLUDE
       #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
       #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
       CBUFFER_START(UnityPerMaterial)
	    float4 _MainTex_ST;
	    float4 _BaseColor;
		float _SpecularRange;
		float4 _SpecularColor;
       CBUFFER_END

	   TEXTURE2D(_MainTex);
	   SAMPLER(sampler_MainTex);

       struct a2v
       {
           float4 positionOS:POSITION;
           float4 normalOS:NORMAL;
           float2 texcoord:TEXCOORD0;
       };

       struct v2f
       {
           float4 positionCS:SV_POSITION;
           float3 positionWS:TEXCOORD0;
           float3 normalWS:NORMAL;
           float2 texcoord:TEXCOORD1;
       };
       ENDHLSL

       Pass
       {
          Tags
          {
              "LightMode" = "UniversalForward"
          }
          HLSLPROGRAM
          #pragma vertex vert
          #pragma fragment frag

          v2f vert(a2v i){
              v2f o;
              o.positionCS = TransformObjectToHClip(i.positionOS.xyz);
              o.positionWS = TransformObjectToWorld(i.positionOS.xyz);
              o.normalWS = TransformObjectToWorldNormal(i.normalOS.xyz);
              o.texcoord = TRANSFORM_TEX(i.texcoord,_MainTex);
              return o;
          }        

          half4 frag(v2f o):SV_Target{
              Light mainLight = GetMainLight();
		      float4 tex = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, o.texcoord)*_BaseColor;

              half3 diffuse = saturate(dot(o.normalWS,normalize(mainLight.direction)))*0.5+0.5;//diffuse
              half3 viewDirWS =  normalize(_WorldSpaceCameraPos-o.positionWS);
              float3 halfVec = SafeNormalize(mainLight.direction+viewDirWS);
              half ndoth = saturate(dot(halfVec,o.normalWS));
              half3 modifier = pow(ndoth,_SpecularRange)*_SpecularColor.xyz*mainLight.color;
              //half3 modifier = LightingSpecular(mainLight.color,mainLight.direction,o.normalWS,viewDir,_SpecularColor,_SpecularRange);
              float3 col = diffuse* tex.xyz*_BaseColor.xyz+modifier;

              return half4(col,1);
          }  
          ENDHLSL
       }
    }
     SubShader
    {
       Tags
       {
         "RenderType" = "Qpaque"

       }

       LOD 100
       Pass
       {
          Tags
          {
              "LightMode" = "UniversalForward"
          }
          HLSLPROGRAM
          #pragma vertex vert
          #pragma fragment frag

          v2f vert(a2v i){
              v2f o;
              o.positionCS = TransformObjectToHClip(i.positionOS.xyz);
              o.positionWS = TransformObjectToWorld(i.positionOS.xyz);
              o.normalWS = TransformObjectToWorldNormal(i.normalOS.xyz);
              o.texcoord = TRANSFORM_TEX(i.texcoord,_MainTex);
              return o;
          }        

          half4 frag(v2f o):SV_Target{
              Light mainLight = GetMainLight();
		      float4 tex = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, o.texcoord)*_BaseColor;

              half3 diffuse = saturate(dot(o.normalWS,normalize(mainLight.direction)))*0.5+0.5;//diffuse
              half3 viewDirWS =  normalize(_WorldSpaceCameraPos-o.positionWS);
              float3 halfVec = SafeNormalize(mainLight.direction+viewDirWS);
              half ndoth = saturate(dot(halfVec,o.normalWS));
              half3 modifier = pow(ndoth,_SpecularRange)*_SpecularColor.xyz*mainLight.color;
              //half3 modifier = LightingSpecular(mainLight.color,mainLight.direction,o.normalWS,viewDir,_SpecularColor,_SpecularRange);
              float3 col = diffuse* tex.xyz*_BaseColor.xyz+modifier;

              return half4(0,0,0,1);
          }  
          ENDHLSL
       }
    }
}
