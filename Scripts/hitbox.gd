class_name Hitbox
extends Area2D

@export var min_damage : int = 5
@export var max_damage : int = 20
@export var critical_chance : float = 0.2
@export var critical_multiplier: int = 2
@export var knockback_enabled: bool = false
@export var knockback_strength: float = 500.0


func _ready() -> void:
	area_entered.connect(_area_entered)

func _area_entered(hurtbox: Area2D) -> void:
	if hurtbox.owner == owner:
		return
	if hurtbox is CustomHurtbox:
		var damage_data = calculate_damage()
		hurtbox.take_damage(damage_data["damage"], damage_data["critical"])
	
func calculate_damage() -> Dictionary:
	var base_damage = randi_range(min_damage, max_damage)
	var is_crit = randf() < critical_chance
	if is_crit:
		base_damage *= critical_multiplier
	return {
		"damage": base_damage,
		"critical": is_crit
	}
