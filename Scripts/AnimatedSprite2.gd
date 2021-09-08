extends AnimatedSprite

func _ready() -> void:
	randomize()
	rotation = rand_range(0, 359)
	global_position = Vector2(rand_range(8, 120), rand_range(8, 120))
