class_name Ammo
extends Area2D

var target
var damages = 5
var speed = 300
var last_target_pos

func _ready():
	pass

func set_target(new_target):
	target = new_target
	look_at(target.get_global_position())

func _physics_process(delta):
	if target != null:
		look_at(target.get_global_position())
		position = position.move_toward(target.get_global_position(), delta* speed)
		last_target_pos = target.get_global_position()
		if target.get_global_position() == position:
			hit()
	else:
		position = position.move_toward(last_target_pos, delta* speed)
		if position == last_target_pos:
			hit()

func hit():
	if target != null:
		target.get_parent().hit(damages)
	queue_free()
