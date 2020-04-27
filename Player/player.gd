extends KinematicBody2D

const maxSpeed = 300
const acceleration = 900
const friction = 1100

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

enum{
	MOVE,
	ROLL
}

var velocity = Vector2.ZERO
var state = MOVE

func _physics_process(delta):
	match state:
		MOVE:
			moveState(delta)
		ROLL:
			rollState(delta)

func moveState(delta):
		# Calculerer input og hatighed
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

func rollState(delta):
	animationState.travel("Roll")
	move_and_slide(velocity)

func rollStateFin():
	state = MOVE
