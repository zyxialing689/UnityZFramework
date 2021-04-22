Shader "Unlit/TestURP"
{
    Properties{
     _MainTex("MainTex",2D)="white"{}
     _NormalTex("NormalTex",2D)="white"{}
     _NormalScale("NormalScale",Range(0,1))=1.0
     _Gloss("Gloss",float)=1.0
    [HDR]_SpecularColor("SpecularColor",color)=(1,1,1,1)
    }
    SubShader{
      Tags{
           "RenderPipeline"="UniversalRenderPipeline"
           "RenderType"="Opaque"
          }    
      HLSLINCLUDE
      #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
      #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
      CBUFFER_START(UnityPerMaterial)
      float4 _MainTex_ST;
      float4 _NormalTex_ST;
      float4 _SpecularColor;
      float _NormalScale;
      float _Gloss;
      CBUFFER_END
      TEXTURE2D(_MainTex);
      TEXTURE2D(_NormalTex);
      SAMPLER(sampler_MainTex);
      SAMPLER(sampler_NormalTex);
      struct InData
      {
         float3 vertex :POSITION;
         float3 normal :NORMAL;
         float4 tangent :TANGENT;
         float2 uv :TEXCOORD;
      };

      struct OutData
      {
          float4 position:SV_POSITION;
          float4 worldNormal:NORMAL;
          float4 worldTangent:TANGENT;
          float4 BworldTangent:TEXCOORD;
          float4 uvs:TEXCOORD1;
      };

      ENDHLSL
      Pass{
        HLSLPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        OutData vert(InData i)
      {
          OutData o;
          o.position = TransformObjectToHClip(i.vertex);
          o.worldNormal.xyz = TransformObjectToWorldNormal(i.normal);
          o.worldTangent.xyz = TransformObjectToWorldDir(i.tangent.xyz);
          o.BworldTangent.xyz = cross(o.worldNormal.xyz,o.worldTangent.xyz)*i.tangent.w;
          float3 worldPos = TransformObjectToWorld(i.vertex);
          o.worldTangent.w = worldPos.x;
          o.BworldTangent.w = worldPos.y;
          o.worldNormal.w = worldPos.z;
          o.uvs.zw = TRANSFORM_TEX(i.uv,_NormalTex);
          o.uvs.xy = TRANSFORM_TEX(i.uv,_MainTex);
          return o;
      }
        float4 frag(OutData o):SV_Target{

            float3x3 TW = float3x3(o.worldTangent.xyz,o.BworldTangent.xyz,o.worldNormal.xyz);
            float4 normalTex = SAMPLE_TEXTURE2D(_NormalTex,sampler_NormalTex,o.uvs.zw);
            float4 MainTexColor = SAMPLE_TEXTURE2D(_MainTex,sampler_MainTex,o.uvs.xy);
            float3 bump = UnpackNormal(normalTex);
            bump.xy*=_NormalScale;
            bump.z = sqrt(1-dot(bump.xy,bump.xy));
            bump = mul(transpose(TW),bump);
            float3 worldPos = float3(o.worldTangent.w,o.BworldTangent.w,o.worldNormal.w);
            Light light = GetMainLight();
            float3 viewDir = normalize(_WorldSpaceCameraPos-worldPos);
            float3 halfDir = normalize(light.direction+viewDir);
            float3 specular = pow(saturate(dot(halfDir,bump)),_Gloss)*_SpecularColor;
            float3 diffuse = saturate(dot(light.direction,bump))*MainTexColor;
            return float4(diffuse+specular,1);
        }
      
        ENDHLSL
      }
    }
}
