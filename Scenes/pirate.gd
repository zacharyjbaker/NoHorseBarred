extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
var fireball_proj = preload("res://Assets/Prefabs/evil_fireball.tscn")
@onready var timer = $Timer

const SPEED = 100.0
const MAX_SPEED = 100.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	anim.play("Idle")
	timer.start(3)

func _physics_process(delta: float) -> void:
	if velocity.x > -MAX_SPEED:
		velocity.x -=  SPEED
	move_and_slide()
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.get_node("HitBox"):
		if body.get_node("HitBox").is_in_group("fireball"):
			print ("hit")
			body.queue_free()
		elif body.get_node("HitBox").is_in_group("ship"):
			body.lost_hp()
			print ("hit")
			body.queue_free()
			
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


func _on_timer_timeout() -> void:
	shoot() # Replace with function body.
	timer.start(3)
