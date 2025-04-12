extends AirState

@export var attack_2 : StringName
@export var attack_3 : StringName
var is_slamming = false
var slam_played = false

func _enter() -> void:
	super()
	character.animation_tree.animation_finished.connect(_on_animation_finished)
	blackboard.set_var(BBNames.attack_var, false)

func _update(delta: float) -> void:
	super(delta)

	if character.is_on_floor():
		if character.animation_state_machine.get_current_node() == attack_3 and not is_slamming:
			character.velocity.x = 0
			character.animation_state_machine.travel("air_attack_end")
			is_slamming = true
		elif not is_slamming:
			dispatch("finished")
	
func _exit() -> void:
	slam_played = false
	is_slamming = false
	character.animation_tree.animation_finished.disconnect(_on_animation_finished)
	
	
func _on_animation_finished(p_animation : StringName):
	if not blackboard.get_var(BBNames.attack_var):
		dispatch("finished")
		return
	
	match p_animation:
		animation_name:
			if !character.is_on_floor():
				character.animation_state_machine.travel(attack_2)
				blackboard.set_var(BBNames.attack_var, false)
		attack_2:
			if attack_3.is_empty():
				dispatch("finished")
				
			character.animation_state_machine.travel(attack_3)
			blackboard.set_var(BBNames.attack_var, false)
		_:
			dispatch("finished")
			
