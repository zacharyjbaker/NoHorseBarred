extends CharacterBody2D
@onready var anim = $Sprite2D
@export var death_sfx : Node
var fireball_proj = preload("res://Assets/Prefabs/evil_fireball.tscn")
@onready var timer = $Timer

@export var SPEED = 100.0
@export var MAX_SPEED = 100.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	#anim.play("Idle")
	timer.start(3)
	death_sfx = get_node("../Node2D/Death")

func _physics_process(delta: float) -> void:
	if velocity.x > -MAX_SPEED:
		velocity.x -=  SPEED
	move_and_slide()
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.get_node("HitBox"):
		if body.get_node("HitBox").is_in_group("fireball"):
			print ("fireball")
			body.queue_free()
			death_sfx.play()
			self.queue_free()
		elif body.get_node("HitBox").is_in_group("ship"):
			body.lost_hp()
			print ("ship collision")
			death_sfx.play()
			self.queue_free()
		elif body.get_node("HitBox").is_in_group("base"):
			print ("despawn")
			self.queue_free()
'''
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
'''

#func _on_hurt_box_area_entered(area: Area2D) -> void:
	#get_node("/root/Node2D/Airship").lost_hp()
	#print ("hit")
	#self.queue_free()
