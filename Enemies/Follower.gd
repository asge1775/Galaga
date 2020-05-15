extends PathFollow2D
onready var timer = get_node("../../../SpawnTimer")
onready var path = get_node("../../Path2D")

export var speed = 100
export var spawnTime = 0

func _process(delta):
	if timer.wait_time - timer.time_left >= spawnTime + path.time:
		set_physics_process(true)
	else:
		set_physics_process(false)

func _physics_process(delta):
	self.set_offset(self.get_offset() + speed * delta)
