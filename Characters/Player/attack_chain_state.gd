extends GroundState

@export var attack_2 : StringName
@export var attack_3 : StringName

func _enter() -> void:
	super()
	character.animation_tree.animation_finished.connect(_on_animation_finished)
	blackboard.set_var(BBNames.attack_var, false)
	
	
func _exit() -> void:
	character.velocity.y = 0
	character.animation_tree.animation_finished.disconnect(_on_animation_finished)
	
	
func _on_animation_finished(p_animation : StringName):
	if not blackboard.get_var(BBNames.attack_var):
		dispatch("finished")
		return
	
	match p_animation:
		animation_name:
			character.animation_state_machine.travel(attack_2)
			blackboard.set_var(BBNames.attack_var, false)
		attack_2:
			if attack_3.is_empty():
				dispatch("finished")
				
			character.animation_state_machine.travel(attack_3)
			blackboard.set_var(BBNames.attack_var, false)
		_:
			dispatch("finished")
			
