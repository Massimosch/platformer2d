extends NPCCharacters

class_name MushroomZombie

var dead : bool = false
var taking_damage : bool = false
var dir : Vector2
var knockback_force = 200
var is_roaming: bool = true
var is_chase : bool = true


func _process(delta):
	if !is_on_floor():
		velocity.y += character_stats.max_fall_speed * delta
		velocity.x = 0
	move(delta)
	move_and_slide()
	
func move(delta):
	if !dead:
		if is_chase:
			velocity += dir * character_stats.run_speed * delta
		is_roaming = true
	elif dead:
		velocity.x = 0
	

func _on_direction_timer_timeout():
	$DirectionTimer.wait_time = choose([1.5, 2.0, 2.5])
	if !is_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0
	
func choose(array):
	array.shuffle()
	return array.front()
