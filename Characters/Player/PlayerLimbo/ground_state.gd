extends CharacterState

var can_move : bool = true

func _enter() -> void:
	super()
	blackboard.set_var(BBNames.jumps_made_var, 0)
	land()
	
func _update(_delta: float) -> void:
	if not can_move:
		return
		
	move()
	
	if character.is_on_floor():
		if blackboard.get_var(BBNames.jump_var) && blackboard.get_var(BBNames.jumps_made_var) == 0:
			jump()
	else:
		dispatch("in_air")
		
	if blackboard.get_var(BBNames.attack_var):
		dispatch("attack")
		
func move() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	character.animation_tree.set("parameters/Move/blend_position", direction.x)
	
	if not is_zero_approx(direction.x):
		character.velocity.x = direction.x * character_stats.run_speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character_stats.run_speed)
		
	character.move_and_slide()
	return character.velocity
	
	
func jump():
	character.velocity.y = -character_stats.jump_velocity
	var current_jumps : int = blackboard.get_var(BBNames.jump_var)
	blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
	dispatch("jump")
	
func land():
	can_move = false
	await get_tree().create_timer(0.2).timeout
	can_move = true
	
