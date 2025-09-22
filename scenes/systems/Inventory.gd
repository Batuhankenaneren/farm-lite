extends Node

var hotbar: Array[String] = ["hoe", "seed_wheat", "watering_can"]
var selected := 0

func select(i:int) -> void:
	if i >= 0 and i < hotbar.size():
		selected = i

func get_selected_id() -> String:
	return hotbar[selected]
