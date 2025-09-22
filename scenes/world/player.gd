extends CharacterBody2D

@onready var world := get_parent()
@onready var ground := world.get_node("Ground")          # TileMapLayer
@onready var crops  := world.get_node("CropManager")     # Ekim/sulama için

@export var speed: float = 140.0

func _physics_process(_d: float) -> void:
	var dir := Vector2.ZERO
	if Input.is_action_pressed("ui_right"): dir.x += 1
	if Input.is_action_pressed("ui_left"):  dir.x -= 1
	if Input.is_action_pressed("ui_down"):  dir.y += 1
	if Input.is_action_pressed("ui_up"):    dir.y -= 1

	velocity = dir.normalized() * speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var cell := _mouse_cell()
		match Inventory.get_selected_id():
			"seed_wheat":
				var data: CropData = load("res://data/crops/Wheat.tres")
				crops.plant(cell, data)
			"watering_can":
				crops.water(cell)
			"hoe":
				pass
	elif event.is_action_pressed("harvest"):
		crops.harvest(_mouse_cell())
	else:
		for i in range(1, 4):
			if event.is_action_pressed("hotbar_%d" % i):
				Inventory.select(i - 1)

func _mouse_cell() -> Vector2i:
	var p := get_global_mouse_position()
	return ground.local_to_map(ground.to_local(p))
