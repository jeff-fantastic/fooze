extends RigidBody2D

export (float) var GOO_AMOUNT = 100
var mass_bullet = preload("res://prefabs/mass.tscn")

func _ready():
	pass

func _physics_process(_delta):
	# Automatically tween both collision and visuals based on goo (also clamping them to be not too big or small)
	$col.scale = Vector2(clamp(lerp($col.scale.x, GOO_AMOUNT / 50, 0.05), 0.2, 2), clamp(lerp($col.scale.y, GOO_AMOUNT / 50, 0.05), 0.2, 2))
	$vis.scale = Vector2(clamp(lerp($vis.scale.x, GOO_AMOUNT / 50, 0.05), 0.2, 2), clamp(lerp($vis.scale.y, GOO_AMOUNT / 50, 0.05), 0.2, 2))
	# Also scale the spawn gimbal so it constantly adjusts to the goo amount
	$spawn_gimbal.scale = Vector2(clamp(lerp($spawn_gimbal.scale.x, GOO_AMOUNT / 50, 0.05), 0.2, 2), clamp(lerp($spawn_gimbal.scale.y, GOO_AMOUNT / 50, 0.05), 0.2, 2))
	$spawn_gimbal.look_at(get_global_mouse_position()) # look at mouse
	mass = clamp(GOO_AMOUNT / 50, 0.5, 1.5) # make heavier based on goo amount
	move() # move physics

func move():
	if Input.is_action_pressed('ui_right'): # if pressing right...
		apply_central_impulse(Vector2(5, 0)) # push right
	if Input.is_action_pressed('ui_left'): # if pressing left...
		apply_central_impulse(Vector2(-5, 0)) # push left
	if Input.is_action_pressed("click"): # holding down click...
		if GOO_AMOUNT > 0: # if goo is not empty...
			spawn_mass() # spawn a piece of mass...
			var dir = (global_position - get_global_mouse_position()).normalized() # get direction of mouse
			apply_central_impulse(dir * 16) # go opposite o mouse direction
			GOO_AMOUNT -= 1 # remove goo

func spawn_mass():
	var new_mass = mass_bullet.instance() # instance goo
	new_mass.global_position = $spawn_gimbal/spawn_point.global_position # move goo position to spawn point
	get_parent().add_child(new_mass) # add node to scene

func _on_detector_body_entered(body):
	if body.is_in_group("mass"): # is mass?
		if body.ENABLED: # and enabled?
			GOO_AMOUNT += body.TARGET_SCALE * 10 # add goo based on mass particle scale
			body.queue_free() # delete mass particle
