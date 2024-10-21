extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@export var victor = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.Victor != victor:
		self.visible = false

# Called every frame. 'delta' is the elap	sed time since the previous frame.
func _physics_process(delta: float) -> void:
	animated_sprite.play("Run")
	if Input.is_action_just_pressed("horsemen") or Input.is_action_just_pressed("walrus") or Input.is_action_just_pressed("babayaga"):
		print ("Start!")
		Global.Start = false
		get_tree().change_scene_to_file("res://Scenes/splash.tscn")

		
	
	
