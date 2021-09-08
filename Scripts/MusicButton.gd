extends Button

func _ready() -> void:
	text = "MUSIC: " + ("ON" if MusicController.is_playing else "OFF")

func _on_MusicButton_pressed() -> void:
	MusicController.is_playing = !MusicController.is_playing
	text = "MUSIC: " + ("ON" if MusicController.is_playing else "OFF")
	MusicController.get_node("Music").playing = MusicController.is_playing
