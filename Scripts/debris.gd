extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var audiostream = $AudioStreamPlayer2D
@export var death_sfx : Node
var fireball_proj = preload("res://Assets/Prefabs/evil_fireball.tscn")
@onready var timer = $Timer

@export var SPEED = 100.0
@export var MAX_SPEED = 100.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	#anim.play("Idle")
	timer.start(6)
	death_sfx = get_node("../Node2D/Death")

func _physics_process(delta: float) -> void:
	if velocity.x > -MAX_SPEED:
		velocity.x -=  SPEED
	move_and_slide()
	var degrees_per_second = 360.0
	if self.is_in_group("largedebris"):
		rotate(delta / 7.5 * deg_to_rad(degrees_per_second))
	else:
		rotate(delta / 2.5 * deg_to_rad(degrees_per_second))
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.get_node("HitBox"):
		if body.get_node("HitBox").is_in_group("fireball"):
			print ("fireball")
			body.queue_free()
			if self.name == "SmallDebris":
				self.queue_free()
				death_sfx.play()
		elif body.get_node("HitBox").is_in_group("ship"):
			body.lost_hp()
			print ("ship collision")
			death_sfx.play()
			self.queue_free()
		elif body.get_node("HitBox").is_in_group("base"):
			print ("despawn")
			self.queue_free()

#func _on_hurt_box_area_entered(area: Area2D) -> void:
	#get_node("/root/Node2D/Airship").lost_hp()
	#print ("hit")
	#self.queue_free()
