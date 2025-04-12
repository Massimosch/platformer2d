extends GroundState

func _enter() -> void:
	super()
	blackboard.set_var(BBNames.jumps_made_var, 0)
	land()
	
func _update(delta: float) -> void:
	super(delta)
		
	if blackboard.get_var(BBNames.attack_var):
		dispatch("attack")
		
func land():
	can_move = false
	await get_tree().create_timer(0.2).timeout
	can_move = true
	
