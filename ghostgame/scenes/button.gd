extends Button
@onready var overlay_screen = $Overlay

func isPressed():
	overlay_screen.hide();
