extends State
class_name WallState

@export var jump_velocity : float = -200.0
@export var air_state : State
@export var jump_animation : String = ""
@export var wall_animation : String = ""


func state_process(_delta):
	if (!character.is_on_wall() and !character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
