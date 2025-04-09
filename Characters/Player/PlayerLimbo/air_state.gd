extends CharacterState

var have_double_jumped : bool = false
var coyote_time : float = 0.2
var coyote_timer : float = 0.0
var can_coyote_jump : bool = false

func _enter():
	super()
	have_double_jumped = false
	coyote_timer = 0.0
	can_coyote_jump = blackboard.get_var(BBNames.jumps_made_var) == 0
	

func _update(_delta: float) -> void:
	air_moving()
	select_animation_state()
	character.move_and_slide()
	print("Current jumps made: ", blackboard.get_var(BBNames.jumps_made_var))
	character.velocity.y = min(character.velocity.y, character_stats.max_fall_speed)

	if character.is_on_floor():
		have_double_jumped = false
		coyote_timer = 0.0
		can_coyote_jump = true
		dispatch("on_ground")
	else:
		coyote_timer += _delta
		if coyote_timer > coyote_time:
			can_coyote_jump = false
		
func select_animation_state():
	if character.velocity.y <= 0.0 && !have_double_jumped:
		character.animation_state_machine.travel("jump")
	elif character.velocity.y <= 0.0 && have_double_jumped:
		character.animation_state_machine.travel("double_jump")
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
		
	if Input.is_action_just_pressed("jump"):
		if can_coyote_jump:
			do_coyote_jump()
		elif !have_double_jumped:
			try_double_jump()
		
	return character.velocity


#####Double Jump---
func try_double_jump():
	character.velocity.y = -character_stats.double_jump_velocity
	var current_jumps : int = blackboard.get_var(BBNames.jump_var)
	blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
	have_double_jumped = true
	dispatch("jump")
	
func do_coyote_jump():
	character.velocity.y = -character_stats.jump_velocity
	can_coyote_jump = false
	coyote_timer = coyote_time
	dispatch("jump")
