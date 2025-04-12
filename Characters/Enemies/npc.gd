class_name NPC
extends NPCCharacters

@export var navigation : NavigationAgent2D
@export var idle_anim : StringName = "idle"
@export var walk_anim : StringName = "move"
var locked_animation = false

func _physics_process(delta):
	apply_gravity(delta)
	select_movement_animation()

func move(_desired_direction : Vector2):
	var move_direction = Vector2(
		_desired_direction.x, 
		0)
		
	var move_velocity = Vector2(move_direction.x * character_stats.run_speed, velocity.y)
	velocity = move_velocity
	move_and_slide()
	
func select_movement_animation():
	if locked_animation:
		return
	
	if velocity.is_zero_approx():
		animation_player.play(idle_anim)
	else:
		animation_player.play(walk_anim)
	
func jump():
	velocity.y -= character_stats.jump_velocity

func apply_gravity(p_delta : float):
	if not is_on_floor():
		velocity += get_gravity() * p_delta

func lock_animation():
	locked_animation = true
	
func unlock_animation():
	locked_animation = false
	
