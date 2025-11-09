extends Node2D

@onready var overlay_screen = $Overlay

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("interaction"):
		overlay_screen.show()


func _on_button_button_down() -> void:
	overlay_screen.hide()


func _on_button_2_pressed() -> void:
	pass 
