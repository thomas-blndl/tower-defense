extends ProgressBar

@onready var base = $"../../Base"

func _ready():
	if base != null:
		base.updateBaseHealthBar.connect(update)

func update(health):
	if base != null:
		max_value = base.max_health
		value = base.health

