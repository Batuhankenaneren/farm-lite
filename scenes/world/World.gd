# res://scenes/world/World.gd
extends Node2D

@onready var pause_menu: Control = $UI/PauseMenu

func _ready() -> void:
	print("[World] ready. pause_menu =", pause_menu)  # konsolda görürsün

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):      # Esc
		print("[World] pause pressed. paused =", get_tree().paused)
		if get_tree().paused:
			return                            # kapatma işini PauseMenu yapacak
		pause_menu.open()
		get_viewport().set_input_as_handled()
