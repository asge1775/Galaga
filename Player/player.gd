extends KinematicBody2D

export var maxSpeed = 300
export var acceleration = 900
export var friction = 1100

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

enum{
	MOVE,
	ROLL,
	SHOOT
}

var velocity = Vector2.ZERO
var state = MOVE

func _physics_process(delta):
	match state:
		MOVE:
			moveState(delta)
		ROLL:
			rollState(delta)
		SHOOT:
			shootState(delta)


# Movement
func moveState(delta):
		# Calculates input and velocity
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var inputVectorNorm = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVectorNorm * maxSpeed, acceleration * delta)
		if inputVector.x != 0:
			animationTree.set("parameters/Idle/blend_position", inputVector.x)
			animationTree.set("parameters/Roll/blend_position", inputVector.x)
			animationTree.set("parameters/Move/blend_position", inputVector.x)
			animationState.travel("Move")
		else:
			animationState.travel("Idle")
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	move_and_slide(velocity)
	
	if Input.is_action_just_pressed("ui_roll"):
		state = ROLL
	if Input.is_action_just_pressed("ui_action"):
		state = SHOOT


# Rolling
func rollState(delta):	# Rollstate start
	animationState.travel("Roll")
	move_and_slide(velocity)
func rollStateFin():	# Rollstate finished
	state = MOVE


# Shooting
func shootState(delta):
	var world = get_tree().current_scene
	var Shootie = load("res://Player/Shootie.tscn")
	var shootie = Shootie.instance()
	world.add_child(shootie)
	shootie.global_position = Vector2(global_position.x, global_position.y - 10)
	
	state = MOVE

func create_explosion_effect():
	var world = get_tree().current_scene
	var ExplosionEffect = load("res://Effects/ExplosionEffect.tscn")
	var explosionEffect = ExplosionEffect.instance()
	
	world.add_child(explosionEffect)
	explosionEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	create_explosion_effect()
	queue_free()
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
