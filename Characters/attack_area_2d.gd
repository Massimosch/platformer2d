class_name AttackArea2D

extends Area2D

@export var damage = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(_body : Node2D):
	if _body is BaseCharacter:
		var damage_dealt = _body.hit(damage)
		print("Dealt %s damage to %s" % [damage_dealt, _body.name])
