extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("horsemen") or Input.is_action_just_pressed("walrus") or Input.is_action_just_pressed("babayaga"):
		print ("Start!")
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
