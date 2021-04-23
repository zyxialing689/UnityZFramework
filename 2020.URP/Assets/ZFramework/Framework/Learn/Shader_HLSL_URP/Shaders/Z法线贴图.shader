Shader "ZURP/Z法线贴图"
{
    Properties
    {
        _MainTex("MainTex",2D)="white"{}
        _BaseColor("BaseColor",Color)=(1,1,1,1)
        _NormalTex("NormalTex",2D)="bump"{}
        _NormalScale("NormalScale",Range(0,1))=1
        _Gloss("Gloss",float)=1.0
    }
    SUbShader
    {
        Tags
        { 
            "RenderType"="Qpaque"
            "RenderPipeline"="UniversalRenderPipeline"

        }
        HLSLINCLUDE

        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

        CBUFFER_START(UnityPerMaterial)
         float4 _MainTex_ST;
         float4 _BaseColor;
         float4 _NormalTex_ST;
         float _NormalScale;
         float _Gloss;
        CBUFFER_END
         TEXTURE2D(_MainTex);
         TEXTURE2D(_NormalTex);
         SAMPLER(sampler_MainTex);
         SAMPLER(sampler_NormalTex);

        struct a2v
        {
           float3 positionOS:POSITION;
           float2 texcoord:TEXCOORD0;
           float3 normalOS:NORMAL;
           float4 tangentOS:TANGENT;
        };

        struct v2f
        {
          float4 positionCS:SV_POSITION;
          float4 uvs:TEXCOORD0;
          float4 tangentWS:TANGENT;
          float4 normalWS:NORMAL;
          float4 BtangentWS:TEXCOORD1;
        };

        ENDHLSL
        
        Pass
        {
            NAME"MainPass"
            Tags
            {
               "LightMode"="UniversalForward"
            }

            HLSLPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            v2f vert(a2v i)
            {
                v2f o;
                o.uvs.xy = TRANSFORM_TEX(i.texcoord,_MainTex);
                o.uvs.zw = TRANSFORM_TEX(i.texcoord,_NormalTex);
                o.positionCS = TransformObjectToHClip(i.positionOS);
                o.normalWS.xyz = normalize(TransformObjectToWorldNormal(i.normalOS));
                o.tangentWS.xyz = normalize(TransformObjectToWorldDir(i.tangentOS.xyz));
                //计算副切线时，叉乘法线，切线，并在乘切线的w值判断正负
                o.BtangentWS.xyz = cross(o.normalWS.xyz,o.tangentWS.xyz)*i.tangentOS.w;
                float3 worldPos = TransformObjectToWorld(i.positionOS);
                o.tangentWS.w = worldPos.x;
                o.BtangentWS.w = worldPos.y;
                o.normalWS.w = worldPos.z;
                return o;
            }

            float4 frag(v2f i):SV_Target
            {
                float3x3 TW = float3x3(i.tangentWS.xyz,i.BtangentWS.xyz,i.normalWS.xyz);
                float3 worldPos = float3(i.tangentWS.w,i.BtangentWS.w,i.normalWS.w);
                float4 normalTex = SAMPLE_TEXTURE2D(_NormalTex,sampler_NormalTex,i.uvs.zw);
                float3 bump = UnpackNormal(normalTex);
                bump.xy *= _NormalScale;
                bump.z = sqrt((1.0-saturate(dot(bump.xy,bump.xy))));
                bump = mul(transpose(TW),bump);

                Light light = GetMainLight();
                half3 albedo = _BaseColor.xyz*SAMPLE_TEXTURE2D(_MainTex,sampler_MainTex,i.uvs.xy).xyz;

                half3 diffuse = albedo*saturate(dot(bump,light.direction));

                half3 viewDir = normalize(_WorldSpaceCameraPos.xyz-worldPos);
                half3 halfDir = normalize(viewDir+light.direction);
                half3 specualr = pow(saturate(dot(halfDir,bump)),_Gloss)*albedo;

                return  half4(diffuse+UNITY_LIGHTMODEL_AMBIENT.xyz*albedo+specualr,1);
            }

            ENDHLSL
        }
    }
}
