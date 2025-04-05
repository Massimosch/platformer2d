extends CharacterState
@export var idle_anim : StringName = "idle"
@export var move_anim : StringName = "run"

func _update(_delta: float) -> void:
	var velocity : Vector2 = move()
	
	if Vector2.ZERO.is_equal_approx(velocity):
		animation_state_machine.travel(idle_anim)
	else:
		animation_state_machine.travel(move_anim)
		
	if blackboard.get_var(BBNames.jump_var) && character.is_on_floor() && blackboard.get_var(BBNames.jumps_made_var) == 0:
		jump()


func move() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	
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
