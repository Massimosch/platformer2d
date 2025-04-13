extends NPCCharacters

@onready var animation_sprite = $AnimatedSprite2D

var jump_power : float = -500
var gravity = 50
var health : float = 30

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

func take_damage(amount: int) -> void:
	health -= amount
	print("Skeleton took ", amount, " damage. Remaining HP: ", health)
	
	if health <= 0:
		die()

func die():
	print("Skeleton died!")
	# Later: play death animation, spawn particles, give XP, etc.
	queue_free()
