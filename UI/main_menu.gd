extends Control

@export var myPlayer : OvaniPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.content_scale_factor = 1
	if VariablesGlobal.music_bool:
		myPlayer.Volume = -60
		myPlayer.FadeIntensity(1, 10)
		myPlayer.FadeVolume(-10, 5)
	
func _process(delta):
	if Input.is_action_just_pressed("music_bool"):
		myPlayer.Volume = -80

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Levels/LobbyLevel.tscn")


func _on_exit_pressed():
	get_tree().quit()
