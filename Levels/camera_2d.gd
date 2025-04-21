extends Camera2D

@export var shake_duration := 0.3
@export var shake_strength := 10.0

var shaking := false
var shake_time := 0.0

var original_offset := Vector2.ZERO

func _ready():
	original_offset = offset

func _process(delta):
	if shaking:
		shake_time -= delta
		if shake_time <= 0:
			shaking = false
			offset = original_offset
		else:
			offset = original_offset + Vector2(
				randf_range(-shake_strength, shake_strength),
				randf_range(-shake_strength, shake_strength)
			)

func start_shake(duration := 0.3, strength := 10.0):
	shake_duration = duration
	shake_strength = strength
	shake_time = duration
	shaking = true
