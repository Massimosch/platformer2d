extends State


class_name LandingState
@export var landing_animation_name : String = ""
@export var ground_state : State
@onready var animation_player = $AnimationPlayer

func _on_animation_tree_animation_finished(anim_name):
	animation_player.stop()
	next_state = ground_state
