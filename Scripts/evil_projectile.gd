extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D
@onready var direction = 0
@export var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print ("Proj Instantiated")
	sprite.play("Fire") # Replace with function body.
	#invert_sprite.play("default")
	velocity.x = velocity.x * speed
	print (velocity.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_slide() 
	if velocity.x < -1:
		scale.y = abs(scale.y)
		rotation_degrees = 0

	elif velocity.x > 1:
		scale.y = -1 * abs(scale.y)
		rotation_degrees = 180
	#print("Laser:", velocity.x)
	

func _on_hurt_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.get_node("HitBox").is_in_group("fireball") or body.get_node("HitBox").is_in_group("base"):
		#body.queue_free()
		self.queue_free()
