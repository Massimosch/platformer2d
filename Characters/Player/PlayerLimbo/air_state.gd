extends CharacterState

func _update(_delta: float) -> void:
	air_moving()
	select_animation_state()

	if character.is_on_floor():
		dispatch("on_ground")
		
func select_animation_state():
	if character.velocity.y <= 0.0:
		character.animation_state_machine.travel("jump")
	else:
		character.animation_state_machine.travel("fall")
		
func air_moving() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	
	if try_double_jump():
		character.animation_state_machine.travel("double_jump")
	
	##Air ACCELERATIO JA DECELARATIO tässä
	if direction.x > 0:
		var attempted_velocity_x = min(character_stats.max_air_speed, character.velocity.x + character_stats.air_acceleration)
		character.velocity.x = max(character.velocity.x, attempted_velocity_x)

	elif direction.x < 0:
		var attempted_velocity_x = max(- character_stats.max_air_speed, character.velocity.x - character_stats.air_acceleration)
		character.velocity.x = min(character.velocity.x, attempted_velocity_x)
		
	character.move_and_slide()
	return character.velocity


#####Double Jump---
func can_double_jump() -> bool:
	var jump_pressed = blackboard.get_var(BBNames.jump_var)
	var jumps_made = blackboard.get_var(BBNames.jumps_made_var)
	return jump_pressed and jumps_made < 2
	
func try_double_jump() -> bool:
	if can_double_jump():
		character.velocity.y = -character_stats.jump_velocity
		var jumps_made = blackboard.get_var(BBNames.jumps_made_var)
		blackboard.set_var(BBNames.jumps_made_var, jumps_made + 1)
		return true
	return false
