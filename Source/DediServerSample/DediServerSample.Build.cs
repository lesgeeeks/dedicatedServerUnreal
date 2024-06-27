// © 2024 Kimmo Kotajärvi <kimmo.kotajarvi@gmail.com>
// This sample is licensed under MIT

using UnrealBuildTool;

public class DediServerSample : ModuleRules
{
	public DediServerSample(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
		PublicDependencyModuleNames.AddRange(new string[] {
			"Core",
			"CoreUObject",
			"Engine",
			"InputCore",
			"EnhancedInput",
			"OnlineSubsystem",
			"OnlineSubsystemUtils"
		});
	}
}
