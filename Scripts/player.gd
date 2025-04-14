class_name Player
extends BaseCharacter

@export var player_actions : PlayerActions
@export var player_stats : PlayerStats
@onready var damage_numbers_origin = $DamageNumbersOrigin
var max_health : int
var current_health: int


func _ready():
	character_stats = player_stats
	max_health = player_stats.max_health
	current_health = max_health
	animation_tree.active = true
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		

func take_damage(damage_amount: int) -> void:
	DamageNumbers.display_number(damage_amount, damage_numbers_origin.global_position, false)
	current_health -= damage_amount
	prints("Player Health now:", current_health)

	if current_health <= 0:
		die()

func die():
	print("Nyt tulee damagea..")
	# Later: play death animation, spawn particles, give XP, etc.
	queue_free()
