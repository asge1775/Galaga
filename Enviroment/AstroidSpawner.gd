extends Node2D

var runs = 0

var spawnTime
var spawnTimeMin = 60
var spawnTimeMax = 420

var spawnSpeedMin = 25
var spawnSpeedMax = 200
var spawnAngleMax = PI/2

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
	spawnTime = rand_range(spawnTimeMin, spawnTimeMax)
	

func _process(delta):
	if runs >= spawnTime:
		spawnTime = rand_range(spawnTimeMin, spawnTimeMax)
		runs = 0
		spawn_astroid(Vector2(rand_range(0,spawnWidth),0), Vector2(0,rand_range(spawnSpeedMin,spawnSpeedMax)))
	runs += 1
