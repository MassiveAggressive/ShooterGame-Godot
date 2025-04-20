@tool

extends Node

enum EItemPrimaryType 
{
	WEAPON,
	GENERATOR,
	EXTRA
}

var ItemPrimaryTypeData: Dictionary[EItemPrimaryType, String] = {
	EItemPrimaryType.WEAPON: "Weapon",
	EItemPrimaryType.GENERATOR: "Generator",
	EItemPrimaryType.EXTRA: "Extra"
}

enum EItemSecondaryType 
{
	PRIMARYWEAPON,
	SECONDARYWEAPON,
	SHIELDGENERATOR,
	SPEEDGENERATOR,
	EXTRA
}

var ItemSecondaryTypeData: Dictionary[EItemSecondaryType, String] = {
	EItemSecondaryType.PRIMARYWEAPON: "Primary Weapon",
	EItemSecondaryType.SECONDARYWEAPON: "Secondary Weapon",
	EItemSecondaryType.SHIELDGENERATOR: "Shield Generator",
	EItemSecondaryType.SPEEDGENERATOR: "Speed Generator",
	EItemSecondaryType.EXTRA: "Extra"
	
}

enum EItemLocation
{
	ININVENTORY,
	INEQUIPMENT
}

enum EOperator
{
	ADD,
	MULTIPLY,
	DIVIDE,
	OVERRIDE
}
