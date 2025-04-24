extends AirState

@export var attack_2 : StringName
@export var attack_3 : StringName
@onready var audioPlayer = $"../../AudioStreamPlayer2D"
var is_slamming = false
var slam_played = false
var attacked = false
var stop_movement = false

func _enter() -> void:
	super()
	character.animation_tree.animation_finished.connect(_on_animation_finished)
	blackboard.set_var(BBNames.attack_var, false)
	audioPlayer.pitch_scale = 1.4
	audioPlayer.play()
	attacked = true

func _update(delta: float) -> void:
	super(delta)

	if attacked:
		character.velocity.y = 20
	if stop_movement:
		character.velocity.y = 500
		character.velocity.x = 0

	if character.is_on_floor():
		if character.animation_state_machine.get_current_node() == attack_3 and not is_slamming:
			character.velocity.x = 0
			character.animation_state_machine.travel("air_attack_end")
			is_slamming = true
		elif not is_slamming:
			dispatch("finished")
	
func _exit() -> void:
	character.velocity.x = 0
	slam_played = false
	is_slamming = false
	character.animation_tree.animation_finished.disconnect(_on_animation_finished)
	attacked = false
	stop_movement = false
	
	
func _on_animation_finished(p_animation : StringName):
	if not blackboard.get_var(BBNames.attack_var):
		VariablesGlobal.have_attacked = true
		dispatch("finished")
		return
	
	match p_animation:
		animation_name:
			if !character.is_on_floor():
				character.animation_state_machine.travel(attack_2)
				audioPlayer.pitch_scale = 2.4
				audioPlayer.play()
				VariablesGlobal.have_attacked = true
				blackboard.set_var(BBNames.attack_var, false)
		attack_2:
			if attack_3.is_empty():
				dispatch("finished")
				
				
			character.animation_state_machine.travel(attack_3)
			audioPlayer.pitch_scale = 2
			audioPlayer.play()
			VariablesGlobal.have_attacked = true
			attacked = false
			stop_movement = true
			blackboard.set_var(BBNames.attack_var, false)
		_:
			dispatch("finished")
			
