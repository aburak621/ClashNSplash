extends Control

func _ready() -> void:
	pass

func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Level.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
