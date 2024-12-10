extends Node2D
@onready var timer = $Timer
var pirate_spawn = preload("res://Assets/Prefabs/pirate.tscn")
var balloon_spawn = preload("res://Assets/Prefabs/balloon.tscn")
var debris_small_spawn = preload("res://Assets/Prefabs/small_debris.tscn")
var debris_large_spawn = preload("res://Assets/Prefabs/large_debris.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_num = rng.randf_range(1.0, 15.0)
	timer.start(random_num)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	
func _on_timer_timeout() -> void:
	var random_enemy_type = rng.randf_range(0.0, 11.0)
	if random_enemy_type < 4.0:
		var pirate = balloon_spawn.instantiate()
		pirate.global_position = global_position
		get_tree().root.add_child(pirate)
	elif random_enemy_type < 7.0:
		var pirate = debris_small_spawn.instantiate()
		pirate.global_position = global_position
		get_tree().root.add_child(pirate)
	elif random_enemy_type < 9.0:
		var pirate = pirate_spawn.instantiate()
		pirate.global_position = global_position
		get_tree().root.add_child(pirate)
	else:
		var pirate = debris_large_spawn.instantiate()
		pirate.global_position = global_position
		get_tree().root.add_child(pirate)
	#pirate.position = position
	#print (velocity.norma	lized().x)
	
	var random_num = rng.randf_range(5.0, 20.0)
	timer.start(random_num)
