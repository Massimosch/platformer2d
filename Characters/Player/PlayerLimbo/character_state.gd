class_name CharacterState
extends LimboState

@export var animation_name : StringName

var character : BaseCharacter
var character_stats : CharacterStats

func _enter() -> void:
	character = agent as BaseCharacter
	character_stats = character.player_stats
	if character.animation_state_machine:
		character.animation_state_machine.travel(animation_name)
	else:
		print("Warning: animation_state_machine is nil!")
		
func _apply_gravity(p_delta : float):
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * p_delta	
