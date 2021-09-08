extends Button

func _ready() -> void:
	text = "PIXELATION: " + ("ON" if MusicController.pixelation else "OFF")

func _on_OptionsButton_pressed() -> void:
	MusicController.pixelation = !MusicController.pixelation
	text = "PIXELATION: " + ("ON" if MusicController.pixelation else "OFF")
	if MusicController.pixelation:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP, Vector2(128, 128))
	elif !MusicController.pixelation:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, Vector2(128, 128))
