extends RigidBody2D

var ENABLED = false
var VALUE = 1
var TARGET_SCALE = 0.1

func _ready():
	var dir = (get_global_mouse_position() - global_position).normalized()
	apply_central_impulse(dir * 256)
	
func _physics_process(delta):
	$vis.scale = lerp($vis.scale, Vector2(TARGET_SCALE, TARGET_SCALE), 0.05)
	$col.scale = lerp($col.scale, Vector2(TARGET_SCALE, TARGET_SCALE) * 7.0, 0.05)

func _on_cooldown_timeout():
	ENABLED = true

func _on_mass_body_entered(body):
	if body.is_in_group("mass"):
		if (VALUE < 5 and body.VALUE < 5) and get_instance_id() > body.get_instance_id():
			VALUE += body.VALUE
			TARGET_SCALE += body.TARGET_SCALE
			body.queue_free()
