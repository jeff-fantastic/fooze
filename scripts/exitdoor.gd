extends Area2D

export (String) var WARP_PATH
var DOOR_ENABLED = false

func _on_radius_body_entered(body):
	if body.get_name() == 'player':
		$vis.animation = "open"
		$door_open.play()
	
func _on_exitdoor_body_entered(body):
	if body.get_name() == 'player' and !DOOR_ENABLED:
		body.SUCK_TARGET = $vis.global_position
		body.PLAYER_STATE = body.STATES.SUCK_INIT
		$door_suck.play()
		DOOR_ENABLED = true
		yield(get_tree().create_timer(2.45), "timeout")
		$pop.visible = true
		$pop.play("default")
		yield(get_tree().create_timer(0.5), "timeout")
		$vis.animation = "close"
		$door_close.play()
		Transit.change_scene(WARP_PATH, 1, 0.75)
