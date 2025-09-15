extends Node2D
<<<<<<< HEAD
=======

@export var aggregator: Aggregator

func _ready() -> void:
	var modifier1: AttributeModifierInfo = AttributeModifierInfo.new(Util.EOperator.ADD, 20)
	var modifier4: AttributeModifierInfo = AttributeModifierInfo.new(Util.EOperator.DIVIDE, 30)
	var modifier2: AttributeModifierInfo = AttributeModifierInfo.new(Util.EOperator.ADD, 30)
	var modifier3: AttributeModifierInfo = AttributeModifierInfo.new(Util.EOperator.MULTIPLY, 2)
	
	aggregator.AddModifier(modifier1)
	
	print(aggregator.Calculate())
	
	aggregator.AddModifier(modifier4)
	print(aggregator.Calculate())
	
	aggregator.AddModifier(modifier2)
	print(aggregator.Calculate())
	
	aggregator.AddModifier(modifier3)
	print(aggregator.Calculate())
	
	
>>>>>>> parent of 13ece42 (Güncelleme)
