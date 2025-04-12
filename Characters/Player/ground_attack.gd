extends CharacterState


@export var attack_2 : StringName
@export var attack_3 : StringName

func _enter() -> void:
	super()
	#character.attack_states.travel("ground_attack_1")
	character.animation_tree.animation_finished.connect(_on_animation_finished)
	
func _exit() -> void:
	character.animation_tree.animation_finished.disconnect(_on_animation_finished)
	
	
func _on_animation_finished(p_animation : StringName):
	if not blackboard.get_var(BBNames.attack_var):
		dispatch("finished")
		return
	
	#match p_animation:
		#animation_name:
			
