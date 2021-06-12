extends CanvasLayer

onready var PlayerStats = get_parent().get_node("player")

func _process(_delta):
	$gloop_cent/prog_bar.value = PlayerStats.GOO_AMOUNT
