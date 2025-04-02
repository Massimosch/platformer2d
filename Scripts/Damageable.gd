extends Node

class_name Damageable

signal on_damage_taken(node : Node, damage_taken: int, knockback_direction : Vector2)

@export var health : float = 20 : 
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
		
@export var dead_animation_name : String = "death"


func take_damage(damage : int, knockback_direction : Vector2):
	health -= damage
	emit_signal("on_damage_taken", get_parent(), damage, knockback_direction)


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		get_parent().queue_free()
