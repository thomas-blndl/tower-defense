class_name Cannon
extends Turret

func _ready():
	super()
	ammo = preload("res://Scenes/Turrets/Cannon/bulletCannon.tscn")
	shoot_cooldown = 1
	price = 50
