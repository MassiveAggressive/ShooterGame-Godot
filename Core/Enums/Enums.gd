extends Node

enum EItemPrimaryType 
{
	WEAPON,
	GENERATOR,
	EXTRA,
	OTHER
}

var EItemPrimaryTypeData: Dictionary[EItemPrimaryType, String] = {
	EItemPrimaryType.WEAPON: "Weapon",
	EItemPrimaryType.GENERATOR: "Generator",
	EItemPrimaryType.EXTRA: "Extra",
	EItemPrimaryType.OTHER: "Other",
}

enum EItemSecondaryType 
{
	PRIMARYWEAPON,
	SECONDARYWEAPON,
	SHIELDGENERATOR,
	SPEEDGENERATOR,
	EXTRA,
	OTHER
}

var EItemSecondaryTypeData: Dictionary[EItemSecondaryType, String] = {
	EItemSecondaryType.PRIMARYWEAPON: "Primary Weapon",
	EItemSecondaryType.SECONDARYWEAPON: "Secondary Weapon",
	EItemSecondaryType.SHIELDGENERATOR: "Shield Generator",
	EItemSecondaryType.SPEEDGENERATOR: "Speed Generator",
	EItemSecondaryType.EXTRA: "Extra",
	EItemSecondaryType.OTHER: "Other",
	
}

enum EItemLocation
{
	ININVENTORY,
	INEQUIPMENT
}
