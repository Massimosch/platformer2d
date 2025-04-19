extends Node2D

@onready var SceneTransitionAnimation = $Camera2D/SceneTransitionAnimation/AnimationPlayer
# Called when the node enters the scene tree for the first time.
var current_wave : int = 0
@export var Flying_Eye_Scene : PackedScene
@export var Skeleton_Scene : PackedScene

var starting_nodes: int
var current_nodes: int
var wave_spawning_ended : bool

func _ready():
	get_tree().root.content_scale_factor = 4
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fade_out")
	current_wave = 0
	VariablesGlobal.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()

func position_to_next_wave():
	if current_nodes == starting_nodes:
		if current_wave != 0:
			VariablesGlobal.moving_to_next_wave = true
		SceneTransitionAnimation.play("between_wave")
		current_wave += 1
		VariablesGlobal.current_wave = current_wave
		await get_tree().create_timer(0.5).timeout
		prepare_spawn("skeleton", 4.0, 4.0)
		prepare_spawn("flying_eye", 2.0, 2.0)
		

func prepare_spawn(type, multiplier, mob_spawns):
	var mob_amount = float(current_wave) * multiplier
	var mob_wait_time : float = 2.0
	var mob_spawn_rounds = mob_amount/mob_spawns
	spawn_type(type, mob_spawn_rounds, mob_wait_time)
	
func spawn_type(type, mob_spawn_rounds, mob_wait_time):
	if type == "skeleton":
		var skeleton_spawn1 = $SkeletonSpawnPoint1
		var skeleton_spawn2 = $SkeletonSpawnPoint2
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var skeleton1 = Skeleton_Scene.instantiate()
				skeleton1.global_position = skeleton_spawn1.global_position
				var skeleton2 = Skeleton_Scene.instantiate()
				skeleton2.global_position = skeleton_spawn2.global_position
				add_child(skeleton1)
				add_child(skeleton2)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time).timeout
		wave_spawning_ended = true
				
				

func _process(_delta):
	if !VariablesGlobal.player_alive:
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		VariablesGlobal.game_started = false
		get_tree().change_scene_to_file("res://Levels/LobbyLevel.tscn")
