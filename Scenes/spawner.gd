extends Node2D
@onready var timer = $Timer
var pirate_spawn = preload("res://Assets/Prefabs/pirate.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_num = rng.randf_range(1.0, 3.0)
	timer.start(random_num)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	
func _on_timer_timeout() -> void:
	var pirate = pirate_spawn.instantiate()
	#print (velocity.norma	lized().x)
	get_tree().root.add_child(pirate)
	var random_num = rng.randf_range(5.0, 20.0)
	timer.start(random_num)
