extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.content_scale_factor = 1

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Levels/level01.tscn")


func _on_exit_pressed():
	get_tree().quit()
