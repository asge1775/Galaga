extends Node2D

var runs = 0

var spawnTime
var spawnTimeLim = [60,240]

var spawnXSpeed = [25,100]
var spawnYSpeed = [-50,50]

var spawnWidth = OS.get_window_size().x
var spawnHeight = 0


func spawn_astroid(position, direction):
	var world = get_tree().current_scene
	var Astroid = load("res://Enviroment/Astroid.tscn")
	var astroid = Astroid.instance()
	
	world.add_child(astroid)
	astroid.global_position = position
	astroid.velocity = direction

func _ready():
	spawnTime = rand_range(spawnTimeLim[0], spawnTimeLim[1])
	

func _process(delta):
	if runs >= spawnTime:
		spawnTime = rand_range(spawnTimeLim[0], spawnTimeLim[1])
		runs = 0
		spawn_astroid(Vector2(rand_range(0,spawnWidth),0), Vector2(rand_range(spawnYSpeed[0],spawnYSpeed[1]),rand_range(spawnXSpeed[0],spawnXSpeed[1])))
	runs += 1
