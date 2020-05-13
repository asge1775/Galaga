extends KinematicBody2D

export var speed = 500
var velocity = Vector2.ZERO


func _physics_process(delta):
	velocity.y = speed * -1
	move_and_slide(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Shootbox_area_entered(area):
	queue_free()
