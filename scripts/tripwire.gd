extends RayCast2D

export (int) var RECIEVER_ID = 0
export (bool) var ENABLED = true
export (bool) var IS_RECIEVER = true
var BUTTON

func _ready():
	if IS_RECIEVER:
		var search = get_parent().get_children()
		for i in get_parent().get_child_count():
			if search[i].get_name().find("button") != -1:
				print("passed1")
				if search[i].SENDER_ID == RECIEVER_ID:
					print("passed2")
					BUTTON = search[i]
		BUTTON.connect("button_enabled", self, "wire_disabled")
		BUTTON.connect("button_disabled", self, "wire_enabled")

func wire_enabled(SENDER_ID):
	print("recieved")
	if SENDER_ID == RECIEVER_ID:
		ENABLED = true
		print("enabled")
		
func wire_disabled(SENDER_ID):
	print("recieved")
	if SENDER_ID == RECIEVER_ID:
		ENABLED = false
		print("disabled")

func _physics_process(_delta):
	if ENABLED:
		update()
	else:
		visible = false

func update():
	force_raycast_update()
	if is_colliding():
		$vis.points[1] = to_local(get_collision_point())
		if get_collider() is RigidBody2D:
			var player = get_collider()
			player.PLAYER_STATE = player.STATES.DISABLED
			Transit.change_scene(get_tree().current_scene.filename, 0.5)
