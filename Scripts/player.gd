class_name Player
extends CharacterBody2D

@export var animation_player : AnimationPlayer
@export var player_actions : PlayerActions
@export var player_stats : PlayerStats
var animation_state_machine = $AnimationTree.get("parameters/playback")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
