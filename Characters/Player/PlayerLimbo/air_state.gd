class_name AirState
extends CharacterState

@export var can_move : bool = true
var have_double_jumped : bool = false
var coyote_time : float = 0.2
var coyote_timer : float = 0.0
var can_coyote_jump : bool = false
var have_attacked = false

func _update(_delta):
	character.move_and_slide()
	if can_move:
		air_moving()

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
	

func do_coyote_jump():
	character.velocity.y = -character_stats.jump_velocity
	can_coyote_jump = false
	coyote_timer = coyote_time
	dispatch("jump")
	
func try_double_jump():
	character.velocity.y = -character_stats.double_jump_velocity
	var current_jumps : int = blackboard.get_var(BBNames.jump_var)
	blackboard.set_var(BBNames.jumps_made_var, current_jumps + 1)
	have_double_jumped = true
	dispatch("jump")
	
