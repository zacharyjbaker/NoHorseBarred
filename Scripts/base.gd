extends Area2D
@export var EndTitle : Node
@export var StartTitle : Node
@export var Countdown : Node
@export var BGMusicPlayer : Node
@onready var timer = $Countdown
@onready var countdownsfx = $CountdownSFX
var end_game_clip = preload("res://Assets/Prefabs/GameOverTheme.wav")
var game_over_init = false
var started = false
var countdown_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if countdown_started == false and started == false and (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down")):
		countdown_started = true
		StartTitle.visible = false
		Countdown.play("default")
		Countdown.visible = true
		timer.start(4)
		countdownsfx.play()
	if started == true:
		if get_tree().paused == true and game_over_init == false:
			print("GameOver")
			EndTitle.visible = true
			BGMusicPlayer.stream = end_game_clip
			BGMusicPlayer.play()
			BGMusicPlayer.volume_db = 0.0
			game_over_init = true
		if get_tree().paused == true and Input.is_action_just_pressed("ui_focus_next"):
			#get_tree().paused = false
			clear_root_nodes()
			get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")
		if Input.is_action_just_pressed("restart"):
			if get_tree().paused == true:
				get_tree().paused = false
			clear_root_nodes()
			get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")

func clear_root_nodes():
	var root = get_tree().root
	for item in root.get_children():
		if item.is_in_group("spawned"):
			root.remove_child(item) 

func _on_countdown_timeout() -> void:
	timer.stop()
	started = true
	countdown_started = false
	Countdown.visible = false
	get_tree().paused = false
