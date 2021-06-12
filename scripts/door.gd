extends StaticBody2D

onready var TOP_COORD = $top.global_position
onready var BOTTOM_COORD = $bottom.global_position
export (int) var RECIEVER_ID = 0
var ENABLED = false
var BUTTON

func _ready():
	var search = get_parent().get_children()
	for i in get_parent().get_child_count():
		if search[i].get_name().find("button") != -1:
			if search[i].SENDER_ID == RECIEVER_ID:
				BUTTON = search[i]
	BUTTON.connect("button_enabled", self, "door_enabled")
	BUTTON.connect("button_disabled", self, "door_disabled")
	
func door_enabled(SENDER_ID):
	print("recieved")
	if SENDER_ID == RECIEVER_ID:
		ENABLED = true
		print("enabled")
		
func door_disabled(SENDER_ID):
	print("recieved")
	if SENDER_ID == RECIEVER_ID:
		ENABLED = false
		print("disabled")

func _process(_delta):
	if ENABLED:
		global_position = lerp(global_position, TOP_COORD, 0.1)
	else:
		global_position = lerp(global_position, BOTTOM_COORD, 0.1)
