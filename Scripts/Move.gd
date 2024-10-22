extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@export var WALK_SPEED = 10
@export var move_input = "horsemen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elap	sed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Global.Start:
		move_and_slide()
		velocity.x =  -WALK_SPEED
		animated_sprite.play("Run")
		#print ("running speed:", WALK_SPEED)
		if Input.is_action_just_pressed(move_input) and WALK_SPEED < 200:
			WALK_SPEED = WALK_SPEED + 8
		#animated_sprite.stop()
		if (WALK_SPEED > 10):
			WALK_SPEED = WALK_SPEED - 0.65
		else:
			WALK_SPEED = 10
			
	
	
