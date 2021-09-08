extends KinematicBody2D

signal damaged
signal shot
signal reloading

onready var pivot := get_parent()
onready var bullet_scene := preload("res://Scenes/Bullet.tscn")
onready var game_over_screen := preload("res://Scenes/GameOverScreen.tscn")
onready var bullet_spawn_position := $CollisionShape2D/Position2D
onready var attack_timer := $AttackTimer
onready var audio_player := $AudioStreamPlayer
onready var reloading_timer := $ReloadingTimer

export var speed: float = 30
export var radius: float = 13
export var bullet_speed: float = 2
export var rpm: int = 3
export var reload_time: float = 2
export var clip_size: int = 8

var bullet_count: int = 8
var reloading: bool = false
var velocity := Vector2()
var health : int = 3
var is_game_over: bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Menu.tscn")
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene("res://Scenes/Level.tscn")
	if !is_game_over:
		var mouse_pos := get_global_mouse_position()
		look_at(get_global_mouse_position())
		
		if (mouse_pos - global_position).length() > 5:
			velocity = global_position.direction_to(get_global_mouse_position()) * speed
			move_and_slide(velocity)
			global_position = pivot.global_position + (global_position - pivot.position).normalized() * radius
		
		if Input.is_action_pressed("lmb"):
			shoot()

func damage(value: int):
	health -= value
	emit_signal("damaged")
	if health <= 0:
		game_over()
		$Sprite.animation = "death"
		$CollisionShape2D.disabled = true

func shoot():
	if attack_timer.is_stopped() and !reloading:
		bullet_count -= 1
		emit_signal("shot")
		audio_player.play()
		attack_timer.start(1.0/rpm)
		var bullet = bullet_scene.instance()
		bullet.init(bullet_speed, rotation, bullet_spawn_position.global_position)
		get_tree().get_root().add_child(bullet)
		if bullet_count <= 0:
			reload()

func reload():
	reloading = true
	emit_signal("reloading")
	reloading_timer.start()
	yield(reloading_timer, "timeout")
	bullet_count = clip_size
	reloading = false
	emit_signal("shot")

func game_over():
	is_game_over = true
	var game_over_screen_instance = game_over_screen.instance()
	get_parent().add_child(game_over_screen_instance)
