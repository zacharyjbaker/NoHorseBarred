extends CharacterBody2D
@onready var timer = $Timer
@onready var anim = $AnimatedSprite2D
var fireball_proj = preload("res://Assets/Prefabs/fireball.tscn")

const SPEED = 300.0
var MAX_SPEED = 300.0
const JUMP_VELOCITY = -400.0
var friction = 0.1

var isPrefiring = false
var isFiring = false
var isCharged = false
var isCharging = false

func _ready() -> void:
	isCharged = true

func _physics_process(delta: float) -> void:
	 
	if !isFiring and !isPrefiring and !isCharging:
		if isCharged:
			anim.play("Charged")
		else:
			anim.play("Idle")
			
	if Input.is_action_just_pressed("ui_focus_next"):
		isCharged = true
		isCharging = true
		anim.play("Charge")
	
	if Input.is_action_pressed("ui_up"):
		if velocity.y > -MAX_SPEED:
			velocity.y -= delta * SPEED
	elif Input.is_action_pressed("ui_down"):
		if velocity.y < MAX_SPEED:
			velocity.y += delta * SPEED
	else:
		velocity.y = lerp(velocity.y, 0.0, friction)
	
	if Input.is_action_pressed("ui_right"):
		if velocity.x < MAX_SPEED:
			velocity.x += delta * SPEED
	elif Input.is_action_pressed("ui_left"):
		if velocity.x > -MAX_SPEED:
			velocity.x -= delta * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
	if Input.is_action_just_pressed("ui_select") and isCharged == true:
		print ("fire")
		anim.play("Fire")
		isPrefiring = true

	move_and_slide()

func _on_animated_sprite_2d_frame_changed() -> void:
	if isPrefiring == true:
		if anim.frame == 5:
			shoot()
			isFiring = true
			isCharged = true
			isPrefiring = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if isFiring == true:
		isFiring = false
		isCharged = false
	if isCharging == true:
		isCharging = false
		
func shoot() -> void:
	var fireball = fireball_proj.instantiate()
	
	if rotation_degrees == 0:
		fireball.velocity.x = 1
		fireball.position = position + Vector2(90, 50)
	else:
		fireball.velocity.x = -1
		fireball.position = position + Vector2(-90, 50)
	#print (velocity.norma	lized().x)
	get_tree().root.add_child(fireball)
