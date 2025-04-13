class_name Hurtbox
extends Area2D

@export var health: Health

var last_attack_vector: Vector2

func take_damage(amount: float, knockback: Vector2) -> void:
	last_attack_vector = knockback

	if health:
		health.take_damage(amount, knockback)
