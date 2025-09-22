extends CanvasLayer

@onready var time_label  : Label = $"Root/TopBar/TimeLabel"
@onready var money_label : Label = $"Root/TopBar/MoneyLabel"
@onready var hotbar_label: Label = $"Root/TopBar/HotbarLabel"

func _ready() -> void:
	_update_all()
	Game.hour_passed.connect(func(_h:int): _update_time())
	Game.day_passed.connect(func(_d:int): _update_time())

func _process(_dt: float) -> void:
	# ucuz olduğu için her frame güncelliyoruz
	_update_money()
	_update_hotbar()

func _update_all() -> void:
	_update_time()
	_update_money()
	_update_hotbar()

func _update_time() -> void:
	time_label.text = "Day %d   %02d:00" % [Game.day, Game.hour]

func _update_money() -> void:
	money_label.text = " $%d" % Game.money

func _update_hotbar() -> void:
	var parts: Array[String] = []
	for i in range(Inventory.hotbar.size()):
		var id := Inventory.hotbar[i]
		# GDScript 4 ternary: <true_value> if <condition> else <false_value>
		parts.append("[%s]" % id if i == Inventory.selected else id)
	hotbar_label.text = "  |  " + "  ".join(parts)
