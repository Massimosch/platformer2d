extends NPCCharacters

@onready var animation_sprite = $AnimatedSprite2D
@onready var damage_numbers_origin = $DamageNumbersOrigin
@export var audiostream : AudioStreamPlayer2D
@onready var healthbar = $Healthbar


var jump_power : float = -500
var gravity = 50
var max_health : int
var current_health: int
var is_dead : bool


func _ready() -> void:
	max_health = character_stats.max_health
	current_health = max_health
	healthbar.init_health(max_health)
	

func _physics_process(_delta):
	if is_on_wall() and is_on_floor():
		velocity.y = jump_power
	else:
		velocity.y += gravity
	move_and_slide()
	

func move(dir, speed):
	
	velocity.x = dir * speed
	handle_animation()
	update_flip(dir)
	
func update_flip(dir):
	if abs(dir) == dir:
		animation_sprite.flip_h = false
		$Hitbox/CollisionShape2D.position.x = abs($Hitbox/CollisionShape2D.position.x)
	else:
		animation_sprite.flip_h = true
		$Hitbox/CollisionShape2D.position.x = -abs($Hitbox/CollisionShape2D.position.x)
	
func handle_animation():
		
	if velocity.x != 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	
func check_for_self(node):
	if node == self:
		return true
	else:
		return false

func attack():
	animation_player.play("attack")
	await animation_sprite.animation_finished
	
func enable_attack_hitbox():
	$Hitbox.monitoring = true
	$Hitbox/CollisionShape2D.disabled = false

func disable_attack_hitbox():
	$Hitbox.monitoring = false
	$Hitbox/CollisionShape2D.disabled = true

func take_damage(damage_amount: int) -> void:
	if current_health < damage_amount:
		damage_amount = current_health
	if current_health > 0:
		healthbar.health = current_health
		DamageNumbers.display_number(damage_amount, damage_numbers_origin.global_position, false)
		HitStopManager.slow_motion_short()
		current_health -= damage_amount
		prints("Health now:", current_health)

	if current_health == 0:
		$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
		die()
		
func update_audio(audio_name: String):
	if audio_name == "none":
		audiostream.stop()
	if audio_name != audiostream["parameters/switch_to_clip"]:
		audiostream.play()
		audiostream["parameters/switch_to_clip"] = audio_name

func die():
	##COME BACK HERE, TERRIBLE WAY TO DO IT BUT IT GOES FOR NOW.
	velocity.x = 0
	$BTPlayer.active = false
	animation_player.play("death")
	await animation_player.animation_finished
	queue_free()
	
	
