extends Node2D

signal gold_ammount_value_changed(value)

var gold_ammount = 100
@onready var gold_node = $"../CanvasLayer/GoldAmmount"

func update_gold_ammount():
	gold_node.text = str(gold_ammount)

func add_gold(value):
	gold_ammount += value
	update_gold_ammount()

func remove_gold(value):
	if gold_ammount - value < 0:
		gold_ammount = 0
	else:
		gold_ammount -= value
	update_gold_ammount()

