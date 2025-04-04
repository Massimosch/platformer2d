extends CharacterBody2D

@onready var animation_sprite = $AnimatedSprite2D

const jump_power = -500
const gravity = 50

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
