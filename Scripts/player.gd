extends CharacterBody2D

class_name Player

@export var speed : float = 200.0
@export_range(0, 1) var deceleration = 0.05
@export_range(0, 1) var acceleration = 0.05
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

#hae gravity projekti settingeistä ja synccc rigidbody nodejen kanssa
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	#VOISI MYÖS VALITA ANIMATION TREESTÄ ACTIVE = ON
	animation_tree.active = true

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = move_toward(velocity.x, direction.x * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	move_and_slide()
	update_animation_parameters()
	update_facing_dir()
	
func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)
		
func update_facing_dir():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
