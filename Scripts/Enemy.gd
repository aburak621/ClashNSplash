extends KinematicBody2D

onready var collider := $CollisionShape2D
onready var audio_player := $AudioStreamPlayer
onready var animated_sprite := $AnimatedSprite

var health: int = 1
var speed: float = .075
var velocity := Vector2.ZERO
var center := Vector2(64, 64)
var collision = null

func move_to_center() -> void:
	velocity = (center - global_position).normalized() * speed
	collision = move_and_collide(velocity)

func radial_spawn(distance: int = 90, random_direction: bool = true, direction: float = 0) -> void:
	var angle := rand_range(0, 359)
	if !random_direction:
		angle = direction
	var angle_rad := deg2rad(angle)
	var spawn_pos = Vector2(cos(angle_rad), sin(angle_rad)) * distance + center
	global_position = spawn_pos

func damage(value: int) -> void:
	health -= value
	if health <= 0:
		explode()

func explode():
	audio_player.play()
	collider.disabled = true
	animated_sprite.animation = "death"
	yield(animated_sprite, "animation_finished")
	queue_free()

func _physics_process(delta: float) -> void:
	if collision != null:
		var collider = collision.collider
		if collider.is_in_group("player"):
			collider.damage(1)
			explode()
		if collider.is_in_group("bullet"):
			collider.queue_free()
			explode()
		if collider.is_in_group("planet"):
			collider.damage(1)
			explode()
