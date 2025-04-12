class_name BaseCharacter
extends CharacterBody2D

@export var animation_player : AnimationPlayer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_state_machine = animation_tree.get("parameters/playback")
@export var character_stats : CharacterStats
@export var sprite : AnimatedSprite2D
