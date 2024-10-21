extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var bg_music = $BGMusic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("default")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	print ("GO!")
	Global.Start = true
	bg_music.play()
	await get_tree().create_timer(1.0).timeout
	self.visible = false
