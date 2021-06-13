extends Area2D

export (int) var SENDER_ID = 0
export (bool) var FOREVER = false
signal button_enabled
signal button_disabled
var ON = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ON:
		$vis.color = Color(1,0,0,1)
	else:
		$vis.color = Color(1,1,1,1)

func _on_button_body_entered(body):
	if body in KinematicBody2D or RigidBody2D:
		ON = true
		emit_signal("button_enabled", SENDER_ID)

func _on_button_body_exited(body):
	if body in KinematicBody2D or RigidBody2D and !FOREVER:
		if get_overlapping_bodies() == []:
			ON = false
			emit_signal("button_disabled", SENDER_ID)

