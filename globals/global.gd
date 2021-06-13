extends Node2D

var Scale = 2
var zark = false
var IsFullscreen = true
var save_path = "res://config/conf.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)
var SFX_volume = 80
var MUS_volume = 70

func change_volume():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), MUS_volume - 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), SFX_volume - 100)

func change_scale():
	var real_width = ProjectSettings.get_setting("display/window/size/width")
	var real_height = ProjectSettings.get_setting("display/window/size/height")
	
	ProjectSettings.set_setting("display/window/size/test_width",real_width * Scale)
	ProjectSettings.set_setting("display/window/size/test_height",real_height * Scale)

	var scale_width = ProjectSettings.get_setting("display/window/size/test_width")
	var scale_height = ProjectSettings.get_setting("display/window/size/test_height")
	

	OS.set_window_size(Vector2(scale_width,scale_height))
	OS.set_window_position(Vector2( (OS.get_screen_size().x / 2) - scale_width / 2, (OS.get_screen_size().y / 2) - scale_height / 2))


func _fade(fade_ms):
	var music = $Music
	$Tween.interpolate_property(music, "volume_db", 0, -80, fade_ms / 100, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	$Tween.start()

func play_song(dir):
	var sfx = load(dir) 
	$Tween.remove($Music, "volume_db")
	$Music.volume_db = 0
	$Music.stream = sfx
	$Music.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	loadConfig()
	change_scale()
	change_volume()

func saveConfig():
	config.set_value("Misc","Scale", Scale)
	config.set_value("Misc","Fullscreen", IsFullscreen)
	config.set_value("Misc","SFX_Volume", SFX_volume)
	config.set_value("Misc","MUS_Volume", MUS_volume)
	config.save(save_path)

func loadConfig():
	Scale = config.get_value("Misc","Scale", Scale)
	IsFullscreen = config.get_value("Misc","Fullscreen", IsFullscreen)
	SFX_volume = config.get_value("Misc","SFX_Volume", SFX_volume)
	MUS_volume = config.get_value("Misc","MUS_Volume", MUS_volume)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
