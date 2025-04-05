class_name CharacterState
extends LimboState

@export var animation_name : StringName

var character : CharacterBody2D
var character_stats : CharacterStats
var animation_state_machine : AnimationTree

func _enter() -> void:
	character = agent as CharacterBody2D
	animation_state_machine = character.animation_state_machine
	animation_state_machine.travel(animation_name)
	character_stats = character.player_stats
