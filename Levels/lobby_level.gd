extends Node2D

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@export var myPlayer : OvaniPlayer

func _ready():
	myPlayer.Volume = -60
	myPlayer.FadeIntensity(1, 10)
	myPlayer.FadeVolume(0, 5)
	VariablesGlobal.player_alive = true
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	get_tree().root.content_scale_factor = 4
	VariablesGlobal.can_move = true
	SceneTransitionAnimation.play("fade_out")


func _process(_delta):
	pass


func _on_level_loader_body_entered(body):
	if body is Player:
		VariablesGlobal.game_started = true
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Levels/level01.tscn")
