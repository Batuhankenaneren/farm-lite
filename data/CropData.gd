extends Resource
class_name CropData

@export var crop_name: String
@export var stages_textures: Array[Texture2D] = []
@export var stage_hours: Array[int] = []        # şimdilik kullanılmıyor
@export var need_water_each_day := true
@export var harvest_yield := 1
@export var seed_item_id: String
@export var sell_price := 5
