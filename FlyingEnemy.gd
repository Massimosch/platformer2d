extends NPCCharacters

@onready var animation_sprite = $AnimatedSprite2D
@onready var damage_numbers_origin = $DamageNumbersOrigin
@onready var healthbar = $Healthbar

var max_health : int
var current_health : int
var is_dead : bool
var is_bat_chase : bool
var is_roaming: bool
var taking_damage : bool
var dead : bool
var dir: Vector2
var speed : float
var player : BaseCharacter

func _ready():
	taking_damage = false
	is_roaming = false
	dead = false
	max_health = character_stats.max_health
	current_health = max_health
	healthbar.init_health(current_health)
	speed = character_stats.max_air_speed
	
func _process(delta):
	if VariablesGlobal.player_alive:
		is_bat_chase = true
	elif !VariablesGlobal.player_alive:
		is_bat_chase = false
		
	
	move(delta)
	handle_animations()
	

func move(delta):
	player = VariablesGlobal.playerBody
	if !dead:
		is_roaming = true
		if !taking_damage and is_bat_chase:
			velocity = position.direction_to(player.position) * speed
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * -50
			velocity = knockback_dir
		elif !is_bat_chase:
			velocity += dir * speed * delta
	elif dead:
		velocity.y += 10 * delta
		velocity.x = 0
	move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !is_bat_chase:
		dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
	
func choose(array):
	array.shuffle()
	return array.front()

func handle_animations():
	if !dead:
		animation_player.play("flying")
		if dir.x == -1:
			animation_sprite.flip_h = true
			$Hitbox/CollisionShape2D.position.x = -abs($Hitbox/CollisionShape2D.position.x)
		elif dir.x == 1:
			animation_sprite.flip_h = false
			$Hitbox/CollisionShape2D.position.x = abs($Hitbox/CollisionShape2D.position.x)
			
func attack():
	animation_player.play("attack")
	await animation_player.animation_finished
	
func take_damage(damage_amount: int, is_crit : bool) -> void:
	if is_crit:
		HitStopManager.slow_motion_short()
	taking_damage = true
	if current_health < damage_amount:
		damage_amount = current_health
	if current_health > 0:
		healthbar.health = current_health
		DamageNumbers.display_number(damage_amount, damage_numbers_origin.global_position, is_crit)

		current_health -= damage_amount
		taking_damage = false
		animation_sprite.play("take_hit")
	
	if current_health == 0:
		healthbar.health = current_health
		$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
		die()
		
func die():
	set_collision_layer_value(1, true)
	set_collision_layer_value(6, false)
	dead = true
	animation_sprite.play("death")
	await get_tree().create_timer(1.5).timeout
	queue_free()
	
	
