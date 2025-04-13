extends Area2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(_body: Node2D) -> void:
	sprite.play("open")

func _on_body_exited(_body):
	sprite.play_backwards("open")
