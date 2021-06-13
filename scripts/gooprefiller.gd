extends Area2D

export (int) var REFILL_AMOUNT = 100

func _on_gooprefiller_body_entered(body):
	if body.get_name() == 'player':
		var player = body
		var children = get_parent().get_children()
		for i in get_parent().get_child_count():
			if children[i].is_in_group('mass'):
				children[i].queue_free()
		player.GOO_AMOUNT = REFILL_AMOUNT
