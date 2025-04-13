class_name Health
extends Node

@onready var damage_numbers_origin = $DamageNumbersOrigin
@export var max_health: float = 10.0
var _current: float

func _ready() -> void:
	_current = max_health

func take_damage(amount: float, _knockback: Vector2) -> void:
#	is critical? crit chance ?
	_current -= amount
	#DamageNumbers.display_number(amount, damage_numbers_origin.global_position, false)
	prints("Health now:", _current)

	if _current <= 0:
		owner.die()
		
func get_current() -> float:
	return _current
