extends AirState


func _enter():
	super()
	have_double_jumped = false
	coyote_timer = 0.0
	can_coyote_jump = blackboard.get_var(BBNames.jumps_made_var) == 0
	
	
func _update(delta: float) -> void:
	super(delta)
	select_animation_state()
	print("Current jumps made: ", blackboard.get_var(BBNames.jumps_made_var))
	
	if not blackboard.get_var(BBNames.attack_var):
		character.velocity.y = min(character.velocity.y, character_stats.max_fall_speed)

	if character.is_on_floor():
		have_double_jumped = false
		coyote_timer = 0.0
		can_coyote_jump = true
		dispatch("on_ground")
	else:
		coyote_timer += delta
		if coyote_timer > coyote_time:
			can_coyote_jump = false
			
	if blackboard.get_var(BBNames.attack_var):
		dispatch("attack")
		
func select_animation_state():
	if character.velocity.y <= 0.0 && !have_double_jumped:
		character.animation_state_machine.travel("jump")
	elif character.velocity.y <= 0.0 && have_double_jumped:
		character.animation_state_machine.travel("double_jump")
	else:
		character.animation_state_machine.travel("fall")
		
	
	
