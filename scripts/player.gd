extends RigidBody2D

export (float) var GOO_AMOUNT = 100
var MASS_BULLET = preload("res://prefabs/mass.tscn")
var SUCK_TARGET

enum STATES {
	ENABLED,
	DISABLED,
	SUCK_INIT,
	SUCK
}

var PLAYER_STATE = STATES.ENABLED

func _ready():
	pass

func _physics_process(_delta):
	$camera.zoom = Vector2(clamp(lerp($camera.zoom.x, GOO_AMOUNT / 25, 0.01), 2, 3), clamp(lerp($camera.zoom.y, GOO_AMOUNT / 25, 0.01), 2, 3))
	$spawn_gimbal.scale = Vector2(clamp(lerp($spawn_gimbal.scale.x, GOO_AMOUNT / 50, 0.05), 0.2, 2), clamp(lerp($spawn_gimbal.scale.y, GOO_AMOUNT / 50, 0.05), 0.2, 2))
	$spawn_gimbal.look_at(get_global_mouse_position())
	if $sfx.get_child_count() > 0: # sound cleanup
		var children = $sfx.get_children()
		for i in $sfx.get_child_count():
			if !children[i].playing:
				children[i].queue_free()
	if PLAYER_STATE == STATES.ENABLED:
		$col.scale = Vector2(clamp(lerp($col.scale.x, GOO_AMOUNT / 50, 0.05), 0.2, 2), clamp(lerp($col.scale.y, GOO_AMOUNT / 50, 0.05), 0.2, 2))
		$vis.scale = Vector2(clamp(lerp($vis.scale.x, GOO_AMOUNT / 50, 0.05), 0.2, 2), clamp(lerp($vis.scale.y, GOO_AMOUNT / 50, 0.05), 0.2, 2))
		mass = clamp(GOO_AMOUNT / 50, 1, 1.5)
		move()
	if PLAYER_STATE == STATES.DISABLED:
		mode = RigidBody2D.MODE_STATIC
	if PLAYER_STATE == STATES.SUCK_INIT:
		$tween.interpolate_property($vis, "scale", $vis.scale, Vector2(0,0), 2.45, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$tween.start()
		PLAYER_STATE = STATES.SUCK
	if PLAYER_STATE == STATES.SUCK:
		mode = RigidBody2D.MODE_STATIC
		global_position = lerp(global_position, SUCK_TARGET, 0.1)

func move():
	if Input.is_action_pressed('ui_right'):
		apply_central_impulse(Vector2(5, 0))
	if Input.is_action_pressed('ui_left'):
		apply_central_impulse(Vector2(-5, 0))
	if Input.is_action_pressed("click"):
		if GOO_AMOUNT > 0:
			spawn_mass()
			var dir = (global_position - get_global_mouse_position()).normalized()
			apply_central_impulse(dir * 16)
			GOO_AMOUNT -= 1

func spawn_mass():
	var new_mass = MASS_BULLET.instance()
	new_mass.global_position = $spawn_gimbal/spawn_point.global_position
	get_parent().add_child(new_mass)

func _on_detector_body_entered(body):
	if body.is_in_group("mass"):
		if body.ENABLED:
			var slurp = AudioStreamPlayer2D.new()
			slurp.bus = "Sound"
			slurp.stream = load("res://sfx/slurp.wav")
			slurp.pitch_scale = rand_range(0.7, 1.2)
			slurp.volume_db = rand_range(-15, -5)
			slurp.play()
			$sfx.add_child(slurp)
			GOO_AMOUNT += body.TARGET_SCALE * 10
			body.queue_free()
