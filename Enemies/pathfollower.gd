extends Path2D

export var speed = 100
export var spawnTime = 0

onready var pathFollow = get_node("PathFollow2D")
onready var timer = get_node("../SpawnTimer")

func _process(delta):
	if timer.wait_time - timer.time_left >= spawnTime:
		set_physics_process(true)
	else:
		set_physics_process(false)

func _physics_process(delta):
	pathFollow.set_offset(pathFollow.get_offset() + speed * delta)
