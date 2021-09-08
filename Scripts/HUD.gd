extends Node2D

onready var ship := get_parent().get_node("Pivot/Ship")
onready var planet := get_parent().get_node("Planet")
onready var health_sprite := preload("res://Scenes/Heart.tscn")
onready var planet_health_sprite := preload("res://Scenes/Planet_Heart.tscn")
onready var bullet_sprite := preload("res://Scenes/Bullet_Sprite.tscn")

var hearts = []
var planet_hearts = []
var bullets = []

func draw_health():
	for i in range(hearts.size()):
		hearts[0].queue_free()
		hearts.remove(0)
	for i in range(ship.health):
		var current_sprite := health_sprite.instance()
		current_sprite.global_position = Vector2(3 + i * 6, 3)
		hearts.append(current_sprite)
		add_child(current_sprite)

func draw_planet_health():
	for i in range(planet_hearts.size()):
		planet_hearts[0].queue_free()
		planet_hearts.remove(0)
	for i in range(planet.health):
		var current_sprite := planet_health_sprite.instance()
		current_sprite.global_position = Vector2(3 + i * 6, 8)
		planet_hearts.append(current_sprite)
		add_child(current_sprite)

func draw_bullet():
	for i in range(bullets.size()):
		bullets[0].queue_free()
		bullets.remove(0)
	for i in range(ship.bullet_count):
		var current_sprite := bullet_sprite.instance()
		current_sprite.global_position = Vector2(3 + i * 6, 125)
		bullets.append(current_sprite)
		add_child(current_sprite)

func _ready() -> void:
	ship.connect("damaged", self, "draw_health")
	draw_health()
	planet.connect("damaged", self, "draw_planet_health")
	draw_planet_health()
	ship.connect("shot", self, "draw_bullet")
	draw_bullet()
