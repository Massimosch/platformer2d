class_name PlayerInputSystem
extends Node
@export var player_actions : PlayerActions
@export var limbo_hsm : LimboHSM

var blackboard : Blackboard
var input_direction : Vector2
var is_jumping : bool = false
var air_jump : bool = false

func _ready() -> void:
	blackboard = limbo_hsm.blackboard
	blackboard.bind_var_to_property(BBNames.direction_var, self, "input_direction", false)
	blackboard.bind_var_to_property(BBNames.jump_var, self, "is_jumping", false)

func _process(_delta: float) -> void:
	input_direction = Input.get_vector(player_actions.move_left, player_actions.move_right, player_actions.move_up, player_actions.move_down)
	#prints(blackboard.get_var("direction"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(player_actions.jump):
		is_jumping = true
		
	elif event.is_action_released(player_actions.jump):
		is_jumping = false
		
		
