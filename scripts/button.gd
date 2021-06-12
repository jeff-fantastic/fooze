extends Area2D

var ON = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_overlapping_bodies() == []:
		ON = false
		$Box.color = Color(1,1,1,1)
	else:
		ON = true
		$Box.color = Color(1,0,0,1)
