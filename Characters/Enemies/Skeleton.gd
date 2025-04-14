extends NPCCharacters

@onready var animation_sprite = $AnimatedSprite2D
@onready var damage_numbers_origin = $DamageNumbersOrigin

var jump_power : float = -500
var gravity = 50
var max_health : int
var current_health: int


func _ready() -> void:
	max_health = character_stats.max_health
	current_health = max_health
	

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
	else:
		animation_sprite.flip_h = true
	
func handle_animation():
	if !is_on_floor():
		animation_sprite.play("fall")
		
	if velocity.x != 0:
		animation_sprite.play("walk")
	else:
		animation_sprite.play("idle")
	
func check_for_self(node):
	if node == self:
		return true
	else:
		return false

func attack():
	animation_sprite.play("attack")

func take_damage(damage_amount: int) -> void:
	DamageNumbers.display_number(damage_amount, damage_numbers_origin.global_position, false)
	current_health -= damage_amount
	prints("Health now:", current_health)

	if current_health <= 0:
		die()

func die():
	print("Skeleton died!")
	# Later: play death animation, spawn particles, give XP, etc.
	queue_free()
	
	
