@tool
extends BTAction

@export var max_distance : float = 200.0
var npc : NPC
var rng : RandomNumberGenerator
var desired_direction : Vector2

func _generate_name() -> String:
	return "Navigates to a new point of max distance %s to the left or right of where character is. " % max_distance

func _setup() -> void:
	npc = agent as NPC
	rng = RandomNumberGenerator.new()
	blackboard.bind_var_to_property(BBNames.direction_var, self, "desired_direction")
	
func _enter() -> void:
	npc.navigation.target_position = pick_destination()
	prints(npc.navigation.target_position)
	
func _tick(_delta: float) -> Status:
	if npc.navigation.is_navigation_finished():
		return SUCCESS
		
	if not npc.navigation.is_target_reachable():
		return FAILURE
	
	var next_path = npc.navigation.get_next_path_position()
	desired_direction = npc.global_position.direction_to(next_path)
	blackboard.set_var(BBNames.direction_var, desired_direction)
	
	if reached_horizontally(desired_direction):
		return FAILURE
		
	
	if desired_direction.y < 0 && npc.is_on_floor() && npc.is_on_wall():
		npc.jump()
		
	npc.move(desired_direction)
	
	return RUNNING
	
func pick_destination() -> Vector2:
	var current_position = npc.get_global_mouse_position()
	var offset = rng.randf_range(-max_distance, max_distance)
	var new_destination = Vector2(
		current_position.x + offset,
		current_position.y
	)
	return new_destination

func reached_horizontally(_desired_direction : Vector2) -> bool:
	if is_zero_approx(_desired_direction.x):
		return true
		
	return false
