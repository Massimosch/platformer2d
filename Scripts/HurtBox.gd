class_name Hurtbox
extends Area2D


func take_damage(damage_amount: float, is_crit: bool = false) -> void:
	owner.take_damage(damage_amount, is_crit)
