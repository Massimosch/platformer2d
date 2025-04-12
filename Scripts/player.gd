class_name Player
extends BaseCharacter

@export var player_actions : PlayerActions
@export var player_stats : PlayerStats


func _ready():
	character_stats = player_stats
	animation_tree.active = true
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
