# res://scenes/ui/PauseMenu.gd
extends Control

@export_file("*.tscn")
var main_menu_scene_path := "res://scenes/main_menu/MainMenu.tscn"

@onready var resume_btn: Button = $Panel/VBoxContainer/ResumeButton
# Buton adların: ResumeButton / OptionsButton / QuitButton

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

# PAUSE açıkken Esc'e basılırsa kapat:
func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("pause"):
		close()
		get_viewport().set_input_as_handled()

func open() -> void:
	visible = true
	get_tree().paused = true
	if is_instance_valid(resume_btn):
		resume_btn.grab_focus()

func close() -> void:
	visible = false
	get_tree().paused = false

func _on_ResumeButton_pressed() -> void:
	close()
	
func _on_OptionsButton_pressed() -> void: 
	print("Options pressed")
	
func _on_QuitButton_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(main_menu_scene_path)
