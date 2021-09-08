extends Timer

onready var tween := $Tween
onready var ufo1 := preload("res://Scenes/Ufo1.tscn")
onready var ufo2 := preload("res://Scenes/Ufo2.tscn")
onready var mine := preload("res://Scenes/Mine.tscn")
onready var barrel := preload("res://Scenes/Barrel.tscn")

var total_time: float = 0
var current_difficulty = 1
var burst_used = false
var time_since_burst: float = 0

func _on_Timer_timeout() -> void:
	if current_difficulty == 1:
		var chance = randf()
		if chance <= 0.6:
			spawn_ufo1()
		else:
			spawn_mine()
	if current_difficulty == 2:
		wait_time = 0.75
		var chance = randf()
		if chance <= 0.4:
			spawn_ufo1()
		elif chance <= 0.6:
			spawn_ufo2()
		elif chance <= 0.8:
			spawn_mine()
		else:
			spawn_barrel()
	if current_difficulty == 3:
		wait_time = 0.4
		if !burst_used:
			burst_used = true
			time_since_burst = 0
			for i in range(12):
				spawn_ufo1()
			yield(get_tree().create_timer(3.25), "timeout")
			spawn_mine_burst()
			yield(get_tree().create_timer(3.5), "timeout")
			spawn_barrel_burst()
		else:
			if time_since_burst >= rand_range(25, 35):
				burst_used = false
			var chance = randf()
			if chance <= 0.4:
				spawn_ufo1()
			elif chance <= 0.6:
				spawn_ufo2()
			elif chance <= 0.8:
				spawn_mine()
			else:
				spawn_barrel()

func spawn_ufo1():
	var ufo := ufo1.instance()
	get_parent().add_child(ufo)

func spawn_ufo2(count: int = 4):
	var angle := rand_range(0, 359)
	for i in range(count):
		var ufo := ufo2.instance()
		ufo.radial_spawn(90, false, angle)
		get_parent().add_child(ufo)
		yield(get_tree().create_timer(1.5), "timeout")

func spawn_mine():
	var mine_instance := mine.instance()
	tween.interpolate_property(mine_instance, "scale", Vector2.ZERO, Vector2.ONE, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	get_parent().add_child(mine_instance)

func spawn_barrel():
	var barrel_instance := barrel.instance()
	tween.interpolate_property(barrel_instance, "scale", Vector2.ZERO, Vector2.ONE, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	barrel_instance.radial_spawn(50)
	yield(get_tree().create_timer(0.01), "timeout")
	get_parent().add_child(barrel_instance)

func spawn_barrel_burst():
	for i in range(6):
		var barrel_instance := barrel.instance()
		tween.interpolate_property(barrel_instance, "scale", Vector2.ZERO, Vector2.ONE, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		barrel_instance.radial_spawn(40, false, (i * 60) + randf() * 60)
		yield(get_tree().create_timer(0.01), "timeout")
		get_parent().add_child(barrel_instance)

func spawn_mine_burst():
	for i in range(12):
		var mine_instance := mine.instance()
		tween.interpolate_property(mine_instance, "scale", Vector2.ZERO, Vector2.ONE, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		mine_instance.radial_spawn(60, false, (i * 60) + randf() * 60)
		yield(get_tree().create_timer(0.01), "timeout")
		get_parent().add_child(mine_instance)

func _physics_process(delta: float) -> void:
	total_time += delta
	time_since_burst += delta
	
	if total_time <= 20:
		current_difficulty = 1
	elif total_time <= 60:
		current_difficulty = 2
	elif total_time <= 120:
		current_difficulty = 3
