class_name Hurtbox
extends Area2D


func take_damage(damage_amount: float) -> void:
	owner.take_damage(damage_amount)
