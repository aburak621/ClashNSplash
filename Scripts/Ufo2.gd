extends "res://Scripts/Enemy.gd"

func _init() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_to_center()
