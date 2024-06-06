extends Control

@onready var START_BUTTON: Button = $StartButton
@onready var QUIT_BUTTON: Button = $QuitButton

@export var FIRST_LEVEL: PackedScene = load("res://scenes/level.tscn")

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(FIRST_LEVEL)

func _on_quit_button_pressed():
	get_tree().quit()
