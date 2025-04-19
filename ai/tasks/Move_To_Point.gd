extends BTAction

@export var target_pos_var := &"pos"
@export var dir_var := &"dir"
var stuck_timer := 0.0
@export var max_stuck_time := 2.0
var last_position := Vector2.ZERO
@export var speed_var = 40
@export var tolerance = 10

func _tick(_delta: float) -> Status:
	var target_pos: Vector2 = blackboard.get_var(target_pos_var, Vector2.ZERO)
	var dir = blackboard.get_var(dir_var)

	# Tarkista onko jumissa
	if agent.global_position.distance_to(last_position) < 1:
		stuck_timer += _delta
	else:
		stuck_timer = 0.0
		last_position = agent.global_position

	# Jos ollut liian kauan jumissa
	if stuck_timer > max_stuck_time:
		print("Agentti jumissa! Pysäytetään ja epäonnistutaan.")
		stuck_timer = 0.0
		return FAILURE

	# Normaalin liikkeen logiikka
	if abs(agent.global_position.x - target_pos.x) < tolerance:
		agent.move(dir, 0)
		return SUCCESS
	else:
		agent.move(dir, speed_var)
		return RUNNING
