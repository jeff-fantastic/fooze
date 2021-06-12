extends Node2D

export (int) var LEVEL_ID = 1
export (String) var LEVEL_NAME = "placeholder"
onready var UI = get_node_or_null("ui")

func _ready():
	if UI != null:
		var UI_text = UI.get_node("title_cent/level")
		UI_text.text = "Level " + String(LEVEL_ID) + "\n" + LEVEL_NAME
