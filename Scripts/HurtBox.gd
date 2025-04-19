extends Area2D
class_name CustomHurtbox


func take_damage(damage_amount: float, is_crit: bool = false) -> void:
	owner.take_damage(damage_amount, is_crit)
