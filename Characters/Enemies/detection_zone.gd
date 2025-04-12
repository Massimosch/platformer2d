class_name DetectionZone
extends Area2D

@export var bt_player : BTPlayer

var blackboard : Blackboard
var target : BaseCharacter :
	set(value):
		target = value
		prints("New target %s on %s" % [target, get_parent()])

func _ready() -> void: 
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	blackboard = bt_player.blackboard
	blackboard.bind_var_to_property(BBNames.target_var, self, "target")
	
	
func _on_body_entered(_body : Node2D):
	if _body is BaseCharacter:
		target = _body
		
func _on_body_exited(_body : Node2D):
	if target == _body:
		target = null
	
