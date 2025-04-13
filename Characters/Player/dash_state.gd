extends CharacterState

@export var max_dash_distance = 100.0
@export var dash_curve : Curve
@export var dash_cooldown = 1.0
var dash_start_pos = Vector2.ZERO
var dash_direction = Vector2.ZERO
var can_dash = true
@export var dash_duration = 0.4
var dash_timer := 0.0

func _enter() -> void:
	super()
	if not can_dash:
		dispatch("on_ground")
	
	dash_start_pos = character.global_position
	dash_direction = get_dash_direction()
	can_dash = false
	
func _update(delta):
	if !can_dash:
		handle_dash_movement(delta)
		
	if can_dash && character.is_on_floor():
		dispatch("on_ground")

		
func get_dash_direction() -> Vector2:
	var direction = blackboard.get_var(BBNames.direction_var)
	if direction == Vector2.ZERO:
		return character.velocity.normalized()
	return direction.normalized()


func handle_dash_movement(delta):
	dash_timer += delta
	if dash_timer >= dash_duration:
		dash_timer = 0.0
		can_dash = true
		if character.is_on_floor():
			dispatch("on_ground")
		else:
			dispatch("in_air")
	character.move_and_slide()
