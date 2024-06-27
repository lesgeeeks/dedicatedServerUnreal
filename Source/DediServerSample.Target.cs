// © 2024 Kimmo Kotajärvi <kimmo.kotajarvi@gmail.com>
// This sample is licensed under MIT

using UnrealBuildTool;
using System.Collections.Generic;

public class DediServerSampleTarget : TargetRules
{
	public DediServerSampleTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Game;
		DefaultBuildSettings = BuildSettingsVersion.V4;
		IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_3;
		DediServerSampleTarget.ApplySharedTargetSettings(this);
		ExtraModuleNames.Add("DediServerSample");
		DisablePlugins.Add("OpenImageDenoise");
	}

	internal static void ApplySharedTargetSettings(TargetRules Target)
	{
		Target.bUseLoggingInShipping = true;
		Target.GlobalDefinitions.Add("UE_PROJECT_STEAMSHIPPINGID=480");
        Target.GlobalDefinitions.Add("UE_PROJECT_STEAMPRODUCTNAME=\"spacewar\"");
        Target.GlobalDefinitions.Add("UE_PROJECT_STEAMGAMEDIR=\"spacewar\"");
        Target.GlobalDefinitions.Add("UE_PROJECT_STEAMGAMEDESC=\"Spacewar\"");
	}
}
