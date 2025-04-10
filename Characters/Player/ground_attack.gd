extends CharacterState

@export var attack_2 : StringName
@export var attack_3 : StringName

func _enter() -> void:
	super()
	
	
func _on_animation_finished(p_animation : StringName):
	if not blackboard.get_var(BBNames.attack_var):
		dispatch("finished")
		return
