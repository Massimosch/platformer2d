class_name GroundState
extends CharacterState

@export var can_move : bool = true
@export var can_jump : bool = true
@export var movement_speed_var = "run_speed"

func _update(_delta):
	if can_move:
		move()
		
	if character.is_on_floor():
		if can_jump && blackboard.get_var(BBNames.jump_var) && blackboard.get_var(BBNames.jumps_made_var) == 0:
			jump()
	else:
		dispatch("in_air")

func move() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction_var)
	var move_speed : float = character_stats.get(movement_speed_var)
	character.animation_tree.set("parameters/Move/blend_position", direction.x)
	
	if not is_zero_approx(direction.x):
		character.velocity.x = direction.x * move_speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, move_speed)
		
	character.move_and_slide()
	return character.velocity
	
	
func jump():
	character.velocity.y = -character_stats.jump_velocity
	var current_jumps : int = blackboard.get_var(BBNames.jump_var)
	blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
	dispatch("jump")
	
