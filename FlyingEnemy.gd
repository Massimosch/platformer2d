extends NPCCharacters

@onready var animation_sprite = $AnimatedSprite2D
@onready var damage_numbers_origin = $DamageNumbersOrigin
@onready var healthbar = $Healthbar
@onready var audioPlayer = $AudioStreamPlayer2D


var max_chase_distance : float = 30.0
var points = 100
var max_health : int
var current_health : int
var is_dead : bool
var is_bat_chase : bool
var is_roaming: bool
var taking_damage : bool
var can_attack : bool = true
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
		if player and !taking_damage and is_bat_chase and VariablesGlobal.player_alive:
			var distance_to_player = position.distance_to(player.position)
			if distance_to_player > max_chase_distance:
				velocity = position.direction_to(player.position) * speed
				dir.x = abs(velocity.x) / velocity.x
			else:
				velocity = Vector2.ZERO
				if not taking_damage:
					attack()
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * -50
			velocity = knockback_dir
		elif !is_bat_chase:
			velocity += dir * speed * delta
	elif dead:
		velocity.y += 500 * delta
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
	if !dead and can_attack and !taking_damage:
		animation_player.play("flying")
		if dir.x == -1:
			animation_sprite.flip_h = true
			$Hitbox/CollisionShape2D.position.x = -abs($Hitbox/CollisionShape2D.position.x)
		elif dir.x == 1:
			animation_sprite.flip_h = false
			$Hitbox/CollisionShape2D.position.x = abs($Hitbox/CollisionShape2D.position.x)
			
func attack():
	if !can_attack:
		return
	print("Attack Ajettiin!")
	can_attack = false
	animation_player.play("attack")
	await animation_player.animation_finished
	can_attack = true
	
func take_damage(damage_amount: int, is_crit : bool) -> void:
	if dead or current_health <= 0:
		return
	
	if is_crit:
		HitStopManager.slow_motion_short()
		audioPlayer.pitch_scale = 2
		audioPlayer.play()
	taking_damage = true
	if current_health < damage_amount:
		damage_amount = current_health
		audioPlayer.pitch_scale = 1.3
		audioPlayer.play()
	if current_health > 0:
		audioPlayer.pitch_scale = 1.6
		audioPlayer.play()
		DamageNumbers.display_number(damage_amount, damage_numbers_origin.global_position, is_crit)

		current_health -= damage_amount
		healthbar.health = current_health
		animation_sprite.play("take_hit")
		await animation_sprite.animation_finished
		taking_damage = false
	
	if current_health == 0:
		$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
		die()
		
func die():
	VariablesGlobal.current_score += points
	set_collision_layer_value(4, true)
	set_collision_mask_value(1, true)
	set_collision_layer_value(6, false)
	dead = true
	animation_sprite.play("death")
	await get_tree().create_timer(1.5).timeout
	queue_free()
	
