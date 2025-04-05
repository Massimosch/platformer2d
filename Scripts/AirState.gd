extends State

class_name AirState

@export var landing_state : State
@export var wall_state : State
@export var double_jump_velocity : float = -150
@export var double_jump_animation : String = ""
@export var jump_animation : String = ""
@export var fall_animation : String = ""
@export var landing_animation : String = ""

var has_double_jumped = false
var anim_player : AnimationPlayer
var can_transition_to_fall = true


func on_enter():
	if character.velocity.y > 0:
		playback.travel(fall_animation)

func state_process(_delta):
	if (character.is_on_floor()):
		next_state = landing_state
	elif (character.is_on_wall()):
		next_state = wall_state
	elif character.velocity.y > 0 and playback.get_current_node() != fall_animation and can_transition_to_fall:
		playback.travel(fall_animation)
		
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()
		
func on_exit():
	if (next_state == landing_state):
		playback.travel(landing_animation)
		has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true
	can_transition_to_fall = false
	await get_tree().create_timer(0.5).timeout
	can_transition_to_fall = true
