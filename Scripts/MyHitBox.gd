class_name MyHitBox
extends Area2D

@export var damage = 10

func _init() -> void:
	collision_layer = 16
	collision_mask = 0
