extends Node2D

onready var ship := get_parent().get_node("Pivot/Ship")
onready var crosshair := preload("res://Assets/Sprites/Crosshair.png")
onready var crosshair_reloading := preload("res://CrosshairReload.tres")
onready var audio := $ReloadSound

var cursor_hotspot := Vector2(16, 16)

func reload_animation():
	audio.play()
	for i in range(9):
		Input.set_custom_mouse_cursor(crosshair_reloading.get_frame("default", i), 0, cursor_hotspot)
		yield(get_tree().create_timer(0.25), "timeout")
		Input.set_custom_mouse_cursor(crosshair, 0, cursor_hotspot)

func _ready() -> void:
	ship.connect("reloading", self, "reload_animation")
