extends Node
class_name CropManager

class CropInstance:
	var crop: CropData
	var stage := 0
	var last_watered_day := 0
	var sprite: Sprite2D

var crops: Dictionary = {}  # Vector2i -> CropInstance

@onready var world := get_parent()
@onready var ground := world.get_node("Ground")  # TileMapLayer

func _ready():
	Game.day_passed.connect(_on_day)

func plant(cell: Vector2i, data: CropData):
	if crops.has(cell): return
	var inst := CropInstance.new()
	inst.crop = data
	inst.last_watered_day = Game.day
	var spr := Sprite2D.new()
	if not data.stages_textures.is_empty():
		spr.texture = data.stages_textures[0]
	spr.position = ground.map_to_local(cell)
	world.add_child(spr)
	inst.sprite = spr
	crops[cell] = inst

func water(cell: Vector2i):
	if crops.has(cell):
		crops[cell].last_watered_day = Game.day

func harvest(cell: Vector2i):
	if not crops.has(cell): return
	var inst: CropInstance = crops[cell]
	if inst.stage >= inst.crop.stages_textures.size() - 1:
		Game.money += inst.crop.sell_price * inst.crop.harvest_yield
		inst.sprite.queue_free()
		crops.erase(cell)

func _on_day(_d:int):
	for cell in crops.keys():
		var inst: CropInstance = crops[cell]
		if inst.crop.need_water_each_day and inst.last_watered_day != Game.day:
			continue
		if inst.stage < inst.crop.stages_textures.size() - 1:
			inst.stage += 1
			inst.sprite.texture = inst.crop.stages_textures[inst.stage]
