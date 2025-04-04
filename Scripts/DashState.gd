extends State

class_name DashState

@export var dash_speed = 200.0
@export var dash_max_distance = 100.0
@export var dash_curve : Curve
@export var dash_cooldown = 1.0
@export var ground_state : State
@export var air_state : State
@export var dash_animation : String = ""
@export var player : Player

var dash_start_pos = 0
var dash_direction = 0
var dash_timer = 0

func on_enter():
	if abs(player.velocity.x) > 0:
		player.start_dashing()
		dash_start_pos = character.position.x
		dash_direction = sign(character.velocity.x)
		dash_animation = "slide_start"
		playback.travel(dash_animation)
		dash_timer = dash_cooldown
	else:
		next_state = ground_state if character.is_on_floor() else air_state

func state_process(delta):
	if (player.is_dashing):
		var current_distance = abs(character.position.x - dash_start_pos)
		if current_distance >= dash_max_distance or character.is_on_wall():
			dash_animation = "slide_end"
			playback.travel(dash_animation)
			player.stop_dashing()
			next_state = ground_state if character.is_on_floor() else air_state
		else:
			dash_animation = "slide_loop"
			playback.travel(dash_animation)
			var speed_factor = dash_curve.sample(current_distance / dash_max_distance)
			character.velocity = Vector2(dash_direction * dash_speed * speed_factor, 0)
	if dash_timer > 0:
		dash_timer -= delta
		
func state_input(_event: InputEvent):
	pass

func on_exit():
	player.stop_dashing()
