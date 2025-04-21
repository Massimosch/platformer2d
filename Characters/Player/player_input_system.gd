class_name PlayerInputSystem
extends Node
@export var player_actions : PlayerActions
@export var limbo_hsm : LimboHSM

var blackboard : Blackboard
var input_direction : Vector2
var is_jumping : bool = false
var attack : bool = false
var dash : bool = false

func _ready() -> void:
	blackboard = limbo_hsm.blackboard
	blackboard.bind_var_to_property(BBNames.direction_var, self, "input_direction", false)
	blackboard.bind_var_to_property(BBNames.jump_var, self, "is_jumping", false)
	blackboard.bind_var_to_property(BBNames.attack_var, self, "attack", false)
	blackboard.bind_var_to_property(BBNames.dash_var, self, "dash", false)
	

func _process(_delta: float) -> void:
	if VariablesGlobal.can_move:
		input_direction = Input.get_vector(player_actions.move_left, player_actions.move_right, player_actions.move_up, player_actions.move_down)
	#prints(blackboard.get_var("direction"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(player_actions.jump) and VariablesGlobal.player_alive and VariablesGlobal.can_move:
		is_jumping = true
		
	elif event.is_action_released(player_actions.jump) and VariablesGlobal.player_alive and VariablesGlobal.can_move:
		is_jumping = false
		
	elif event.is_action_pressed(player_actions.dash) and VariablesGlobal.player_alive and VariablesGlobal.can_move:
		dash = true
	
	elif event.is_action_released(player_actions.dash) and VariablesGlobal.player_alive and VariablesGlobal.can_move:
		dash = false
		
	elif event.is_action_pressed(player_actions.attack) and VariablesGlobal.player_alive and VariablesGlobal.can_move:
		attack = true
	
		
		
