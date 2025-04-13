class_name CharacterStats
extends Resource

signal health_depleted()

@export var run_speed : float = 150.0
@export var attacking_move_speed : float = 1.0
@export var max_air_speed : float = 170.0
@export var air_acceleration : float = 200.0
@export var jump_velocity : float = 300.0
@export var double_jump_velocity : float = 250.0
@export var max_fall_speed : float = 500.0

@export var max_health : int = 20
@export var health : int = 20 :
	set(value):
		var old_value = health
		health = value
		
		if health <= 0 && old_value > 0:
			health_depleted.emit()
