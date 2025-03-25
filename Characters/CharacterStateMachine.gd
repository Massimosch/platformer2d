extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			#Set the state up with what they need to function
			child.character = character
			
		else:
			push_warning("Child " + child.name + " is not a State")

func check_if_can_move():
	return current_state.can_move
