extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	connect("body_entered", Victory)
	pass # Replace witha function body.

func Victory(body) -> void:
	print (body.name, " Finished!")
	Global.Victor = body.name
	get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
