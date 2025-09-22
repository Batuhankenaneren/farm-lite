extends Resource
class_name ItemData

@export var item_id: String
@export var display_name: String
@export var type: String            # "seed", "tool", ...
@export var crop: CropData          # type == "seed" ise doldur
