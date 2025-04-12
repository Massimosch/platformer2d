class_name BaseCharacter
extends CharacterBody2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@onready var attack_states = animation_tree.get("parameters/GroundAttacks/playback")
var character_stats : CharacterStats


func _update_animation_parameters():
		animation_tree["parameters/conditions/idle"] = true
