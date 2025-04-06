extends CharacterState

func _update(_delta: float) -> void:
	character.move_and_slide()
	air_moving()
	
	if character.is_on_floor():
		dispatch("on_ground")
		
func air_moving() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction_var)
		
		
	##Air ACCELERATIO JA DECELARATIO tässä
	if direction.x > 0:
		var attempted_velocity_x = min(character_stats.max_air_speed, character.velocity.x + character_stats.air_acceleration)
		character.velocity.x = max(character.velocity.x, attempted_velocity_x)

	elif direction.x < 0:
		var attempted_velocity_x = max(- character_stats.max_air_speed, character.velocity.x - character_stats.air_acceleration)
		character.velocity.x = min(character.velocity.x, attempted_velocity_x)
		
	character.move_and_slide()
	return character.velocity
