extends "res://Scripts/Enemy.gd"

onready var bullet_scene := preload("res://Scenes/Bullet.tscn")

func _init() -> void:
	radial_spawn()

func _physics_process(delta: float) -> void:
	move_to_center()

func explode():
	for i in range(12):
		var bullet = bullet_scene.instance()
		var direction = deg2rad(i * 30)
		bullet.init(3, direction, global_position)
		get_tree().get_root().add_child(bullet)
	.explode()
