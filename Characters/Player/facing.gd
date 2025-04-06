class_name Facing
extends Node2D

@export var character : BaseCharacter

func _physics_process(_delta: float) -> void:
	if character.velocity.x > 0:
		scale.x = 1.0
	elif character.velocity.x < 0:
		scale.x = -1.0
