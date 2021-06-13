extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Title")
	#VisualServer.set_default_clear_color(Color(0,0,0,1.0))
	Global.play_song("res://music/title.ogg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
