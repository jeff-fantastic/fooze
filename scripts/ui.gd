extends CanvasLayer

onready var PlayerStats = get_parent().get_node("player")

func _process(_delta):
	$Layer1/gloop_cent/prog_bar.value = PlayerStats.GOO_AMOUNT
	if Input.is_action_just_pressed("ui_cancel") and PlayerStats.PLAYER_STATE == PlayerStats.STATES.ENABLED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Layer1.visible = false
		$Layer2.visible = true
		get_tree().paused = true

func _on_title_pressed():
	Transit.change_scene("res://misc_scenes/title.tscn", 0.5)
	get_tree().paused = false

func _on_restart_pressed():
	Transit.change_scene(get_tree().current_scene.filename, 0.5)
	get_tree().paused = false
	
func _on_resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Layer1.visible = true
	$Layer2.visible = false
	get_tree().paused = false
