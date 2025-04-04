extends State

class_name GroundState
@export var jump_velocity : float = -200.0
@export var air_state : State
@export var attack_state : State
@export var dash_state : State
@export var jump_animation : String = ""
@export var attack_animation : String = ""
@export var dash_animation : String = ""
@export_range(0, 1) var decelerate_on_jump = 0.5
@onready var buffer_timer : Timer = $BufferTimer


func state_process(_delta):
	if (!character.is_on_floor() && buffer_timer.is_stopped()):
		next_state = air_state
		
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
	if(event.is_action_pressed("attack")):
		attack()
		
	if(event.is_action_pressed("dash")):
		dash()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
	
func attack():
	next_state = attack_state
	playback.travel(attack_animation)

func dash():
	next_state = dash_state
	
