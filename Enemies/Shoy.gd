extends KinematicBody2D
onready var timer = get_node("../../../SpawnTimer")

var runs = 0
export var shootInterval = 60
export var shootStart = 0

func _on_Hurtbox_area_entered(area):
	create_explosion_effect()
	queue_free()

func shoot():
	var world = get_tree().current_scene
	var Bullet = load("res://Enemies/Bullet.tscn")
	var bullet = Bullet.instance()
	world.add_child(bullet)
	bullet.global_position = Vector2(global_position.x, global_position.y + 10)

func create_explosion_effect():
	var world = get_tree().current_scene
	var ExplosionEffect = load("res://Effects/ExplosionEffect.tscn")
	var explosionEffect = ExplosionEffect.instance()
	
	world.add_child(explosionEffect)
	explosionEffect.global_position = global_position

func _process(delta):
	if runs >= shootInterval and timer.wait_time - timer.time_left >= shootStart:
		runs = 0
		shoot()
	runs += 1
