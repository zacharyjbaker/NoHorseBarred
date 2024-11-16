extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("ThreeHP")
	
func lost_hp(amt: int) -> void:
	if amt == 2:
		play("TwoHP")
	elif amt == 1:
		play("OneHP")
	else:
		visible = false
