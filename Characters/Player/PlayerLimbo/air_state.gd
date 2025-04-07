extends CharacterState

var have_double_jumped : bool = false

func _enter():
	super()
	have_double_jumped = false

func _update(_delta: float) -> void:
	air_moving()
	select_animation_state()

	if character.is_on_floor():
		dispatch("on_ground")
		
	if Input.is_action_just_pressed("jump"):
		blackboard.set_var(BBNames.jump_var, true)
		try_double_jump()
	else:
		blackboard.set_var(BBNames.jump_var, false)


		
func select_animation_state():
	if character.velocity.y <= 0.0:
		character.animation_state_machine.travel("jump")
	else:
		character.animation_state_machine.travel("fall")
		
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


#####Double Jump---
func try_double_jump():
	if have_double_jumped:
		return

	character.animation_state_machine.travel("double_jump")
	character.velocity.y = -character_stats.jump_velocity
	var current_jumps : int = blackboard.get_var(BBNames.jump_var)
	blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
	have_double_jumped = true
	dispatch("jump")
