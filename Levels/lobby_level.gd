extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.content_scale_factor = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_level_loader_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://Levels/level01.tscn")
