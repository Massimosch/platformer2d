extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float = -100

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree

#hae gravity projekti settingeistä ja synccc rigidbody nodejen kanssa
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false

func _ready():
	#VOISI MYÖS VALITA ANIMATION TREESTÄ ACTIVE = ON
	animation_tree.active = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
		if was_in_air == true:
			land()
			was_in_air = false

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#Normal jump
			jump()
		elif not has_double_jumped:
			double_jump()
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_dir()
	
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

		
func update_facing_dir():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

func jump():
	velocity.y = jump_velocity
	animation_locked = true

func double_jump():
	velocity.y = double_jump_velocity
	animation_locked = true
	has_double_jumped = true
	
func land():
	animation_locked = true
	
