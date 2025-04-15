extends BTAction

@export var target_var := &"target"
@export var speed_var = 60
@export var tolerance = 20

func _tick(_delta: float) -> Status:
	var target: CharacterBody2D = blackboard.get_var(target_var)
	if target != null:
		var target_position = target.global_position
		var vertical_difference = abs(agent.global_position.y - target_position.y)

		# If Y distance is too much, don't act
		if vertical_difference > 400:
			return FAILURE

		var dir = agent.global_position.direction_to(target_position)

		if abs(agent.global_position.x - target_position.x) < tolerance:
			agent.move(dir.x, 0)
			return SUCCESS
		else:
			agent.move(dir.x, speed_var)
			return RUNNING
		
	return FAILURE
