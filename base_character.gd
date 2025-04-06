class_name BaseCharacter
extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")
var character_stats : CharacterStats
