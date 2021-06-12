extends Node2D

export (int) var LEVEL_ID = 1
export (String) var LEVEL_NAME = "placeholder"

# stick these into the level
var CURSOR = preload("res://prefabs/cursor.tscn")
var UI = preload("res://prefabs/ui.tscn")

func _ready():
	# instance the UI first
	var new_ui = UI.instance()
	var UI_text = new_ui.get_node("title_cent/level")
	UI_text.text = "Level " + String(LEVEL_ID) + "\n" + LEVEL_NAME
	add_child(new_ui)
	
	# then the cursor
	var new_cursor = CURSOR.instance()
	add_child(new_cursor)

