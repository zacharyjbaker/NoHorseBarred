extends CharacterBody2D
@onready var timer = $Timer
@onready var anim = $AnimatedSprite2D
@onready var audiostream = $AudioStreamPlayer2D
@onready var damage_sfx = $Damage
@export var death_sfx : Node
@export var health : Node
var rng = RandomNumberGenerator.new()
var shaking = false
var original_position
var fireball_proj = preload("res://Assets/Prefabs/fireball.tscn")
var playerfire_sfx = preload("res://Assets/SFX/playerfire.mp3")
var reload_sfx = preload("res://Assets/SFX/reload.mp3")

const SPEED = 300.0
var MAX_SPEED = 300.0
const JUMP_VELOCITY = -400.0
var friction = 0.1
var hp = 6

var isPrefiring = false
var isFiring = false
var isCharged = false
var isCharging = false

func _ready() -> void:
	isCharged = true

func _physics_process(delta: float) -> void:
	if shaking:
		var random_num_x = rng.randf_range(-4.0, 4.0)
		var random_num_y = rng.randf_range(-4.0, 4.0)
		anim.position.x += random_num_x
		position.y += random_num_y
	
	if !isFiring and !isPrefiring and !isCharging:
		if isCharged:
			anim.play("Charged")
		else:
			anim.play("Idle")
			
	if Input.is_action_just_pressed("ui_focus_next") and isCharged == false:
		isCharged = true
		isCharging = true
		anim.play("Charge")
		audiostream.stream = reload_sfx
		audiostream.play()
	
	if Input.is_action_just_pressed("ui_up"):
		if velocity.y > -MAX_SPEED:
			velocity.y -= delta * SPEED
			velocity.y -= 50
	elif Input.is_action_just_pressed("ui_down"):
		if velocity.y < MAX_SPEED:
			velocity.y += delta * SPEED
			velocity.y += 50
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
		audiostream.stream = playerfire_sfx
		audiostream.play()
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
	
func shake() -> void:
	timer.start(0.4)
	print ("start shaking")
	shaking = true
	original_position = position

func lost_hp() -> void:
	shake()
	hp -= 1
	if hp > 0:
		damage_sfx.play()
	if hp == 0:
		self.visible = false
		damage_sfx.play()
		death_sfx.play()
	health.lost_hp(hp)
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.get_node("HitBox"):
		if body.get_node("HitBox").is_in_group("evil_fireball"):
			print ("hit")
			lost_hp()
			body.queue_free()

func _on_timer_timeout() -> void:
	print ("stop shaking")
	shaking = false
	#position = original_position
	timer.stop()
