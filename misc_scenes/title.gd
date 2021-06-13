extends Spatial
var konami_counter = 0
var konami_code = ["ui_up","ui_up","ui_down","ui_down","ui_left","ui_right","ui_left","ui_right"]
func _ready():
	$AnimationPlayer.play("Title")
	#VisualServer.set_default_clear_color(Color(0,0,0,1.0))
	$Layer2/mus_slider.value = Global.MUS_volume
	$Layer2/sfx_slider.value = Global.SFX_volume
	Global.play_song("res://music/title.ogg")

func _on_Play_pressed():
	Global._fade(300)
	Transit.change_scene("res://levels/Level_1.tscn")

func _on_Scale_pressed():
	if Global.Scale < 5:
		Global.Scale += 1
	else:
		Global.Scale = 1
	Global.change_scale()
	Global.saveConfig()

func _on_Options_pressed():
	$Layer1.visible = false
	$Layer2.visible = true

func _on_Back_pressed():
	$Layer1.visible = true
	$Layer2.visible = false

func _on_mus_slider_value_changed(value):
	Global.MUS_volume = $Layer2/mus_slider.value
	Global.change_volume()
	Global.saveConfig()
	
func _on_sfx_slider_value_changed(value):
	Global.SFX_volume = $Layer2/sfx_slider.value
	Global.change_volume()
	Global.saveConfig()

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if konami_counter <= konami_code.size()-2:
				if Input.is_action_just_pressed(konami_code[konami_counter]):
					konami_counter += 1
				else:
					konami_counter = 0
			else:
				Global.zark = true

func _process(delta):
	pass
