extends StaticBody2D

signal damaged

onready var ship := get_parent().get_node("Pivot/Ship")

var health: int = 3

func damage(value: int):
	health -= value
	emit_signal("damaged")
	if health <= 0:
		ship.game_over()
		$Planet.animation = "death"
		$CollisionShape2D.disabled = true
