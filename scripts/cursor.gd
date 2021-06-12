extends Sprite

var target_scale = 3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	scale = lerp(scale, Vector2(target_scale, target_scale), 0.1)
	global_position = get_global_mouse_position()
	rotation_degrees += 45 * delta
	if Input.is_action_pressed("click"):
		target_scale = 5
	else:
		target_scale = 3
