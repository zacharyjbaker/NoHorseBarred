extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("SixHP")
	
func lost_hp(amt: int) -> void:
	if amt == 5:
		play("FiveHP")
	elif amt == 4:
		play("FourHP")
	elif amt == 3:
		play("ThreeHP")
	elif amt == 2:
		play("TwoHP")
	elif amt == 1:
		play("OneHP")
	else:
		visible = false
		get_tree().paused = true
