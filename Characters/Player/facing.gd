class_name Facing
extends Node2D

@export var limbo_hsm : LimboHSM
var blackboard : Blackboard

func _ready():
	blackboard = limbo_hsm.blackboard

func _physics_process(_delta: float) -> void:
	var current_input_direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	if current_input_direction.x > 0:
		scale.x = 1.0
	elif current_input_direction.x < 0:
		scale.x = -1.0
