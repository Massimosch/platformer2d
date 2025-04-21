extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func _process(_delta):
	testEsc()
	
func testEsc():
	if Input.is_action_just_pressed("open_menu") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("open_menu") and get_tree().paused == true:
		resume()


func _on_back_to_menu_pressed():
	resume()
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_continue_button_pressed():
	resume()
