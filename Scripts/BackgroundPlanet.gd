extends AnimatedSprite

var time_since_start: float = 0
var speed: float = 0.05
var velocity := Vector2.ZERO
var spawned: bool = false
var direction_range = 30
var spawn_time: float = 1

func _physics_process(delta: float) -> void:
	time_since_start += delta
	if time_since_start >= spawn_time and !spawned:
		spawned = true
		spawn_planet()
	if spawned:
		global_position += velocity

func spawn_planet():
	var angle := rand_range(0, 359)
	var angle_rad := deg2rad(angle)
	var spawn_pos = Vector2(cos(angle_rad), sin(angle_rad)) * 105 + Vector2(64, 64)
	global_position = spawn_pos
	
	angle -= 180
	angle += rand_range(-direction_range, direction_range)
	if angle < 0:
		angle += 360
	angle_rad = deg2rad(angle)
	velocity = Vector2(cos(angle_rad), sin(angle_rad)) * speed
