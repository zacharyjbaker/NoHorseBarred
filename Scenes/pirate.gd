extends CharacterBody2D
@onready var anim = $AnimatedSprite2D

const SPEED = 100.0
const MAX_SPEED = 100.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	anim.play("Idle")

func _physics_process(delta: float) -> void:
	if velocity.x > -MAX_SPEED:
		velocity.x -=  SPEED
	move_and_slide()
