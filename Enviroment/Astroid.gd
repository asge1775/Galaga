extends KinematicBody2D
var velocity = Vector2.ZERO

func _physics_process(delta):
	move_and_slide(velocity)

func create_explosion_effect():
	var world = get_tree().current_scene
	var ExplosionEffect = load("res://Effects/ExplosionEffect.tscn")
	var explosionEffect = ExplosionEffect.instance()
	
	world.add_child(explosionEffect)
	explosionEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	create_explosion_effect()
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
