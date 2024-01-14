class_name Turret
extends CharacterBody2D

var ammo:Resource
var curr_target
var targets_in_range:Array
var can_shoot = true
var shoot_cooldown = 1
var is_active = false
var price = -1

func _ready():
	pass

func _on_area_2d_body_entered(body):
	if body.get_groups().has("Enemy"):
		if curr_target == null:
			curr_target = body
		elif body.get_parent().progress > curr_target.get_parent().progress:
			curr_target = body
		targets_in_range.push_front(body)

func _on_area_2d_body_exited(body):
	targets_in_range.erase(body)
	if body == curr_target:
		if is_active:
			choose_new_target()

func _physics_process(delta):
	if !is_active:
		return
	if curr_target != null:
		look_at(curr_target.get_global_position())

func _process(delta):
	if !is_active:
		return
	if curr_target != null:
		if can_shoot:
			shoot(delta)
	else: 
		if targets_in_range.has(curr_target):
			targets_in_range.erase(curr_target)
		choose_new_target()

func choose_new_target():
	if targets_in_range.size() > 0:
		var highest_progress = 0
		var chosen_target = targets_in_range[0]
		for target in targets_in_range:
			if target.get_parent().progress > highest_progress:
				highest_progress = target.get_parent().progress
				chosen_target = target
		curr_target = chosen_target

func shoot(delta):
	can_shoot = false
	var bullet = ammo.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $Ammo_pos.get_global_position()
	bullet.set_target(curr_target)
	
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
