extends KinematicBody2D

var speed = 500
var velocity = Vector2.ZERO


func _physics_process(delta):
	velocity.y = speed * -1
	move_and_slide(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
