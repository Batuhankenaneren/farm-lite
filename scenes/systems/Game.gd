extends Node

signal hour_passed(current_hour: int)
signal day_passed(current_day: int)

var money := 0
var hour := 6
var day := 1
var time_scale := 1.0   # zamanı hızlandırmak için artırabilirsin

func _ready():
	_tick()

func _tick() -> void:
	await get_tree().create_timer(1.0 / max(time_scale, 0.001)).timeout
	hour += 1
	if hour >= 24:
		hour = 6
		day += 1
		day_passed.emit(day)
	else:
		hour_passed.emit(hour)
	_tick()
