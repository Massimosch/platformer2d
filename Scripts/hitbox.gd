class_name Hitbox
extends Area2D

@export var damage: float = 10
@export var knockback_enabled: bool = false
@export var knockback_strength: float = 500.0


func _ready() -> void:
	area_entered.connect(_area_entered)

func _area_entered(hurtbox: Hurtbox) -> void:
	if hurtbox.owner == owner:
		return
	hurtbox.take_damage(damage)
