extends KinematicBody2D

var velocity := Vector2.UP
var collision = null

func init(speed: float, in_rotation: float, in_position: Vector2) -> void:
	velocity = Vector2(cos(in_rotation), sin(in_rotation)) * speed
	global_position = in_position

func _physics_process(delta: float) -> void:
	collision = move_and_collide(velocity)
	if collision != null:
		var collider = collision.collider
		if collider.is_in_group("enemy"):
			collider.explode()
		queue_free()
