extends Label
class_name FloatUI_Component

@export var float_amplitude: Vector2 = Vector2(6, 4)
@export var float_speed: float = 1.3
@export var float_offset: float = 0.0
@export var hover_scale: float = 1.15
@export var hover_time: float = 0.16

var original_position: Vector2
var original_scale: Vector2
var time: float = 0.0
var active_tween: Tween

func _enter_tree() -> void:
	original_scale = scale
	original_position = position
	pivot_offset = size / 2
	set_process(float_amplitude != Vector2.ZERO)

func _ready() -> void:
	mouse_entered.connect(_on_hover_start)
	mouse_exited.connect(_on_hover_end)

func _process(delta: float) -> void:
	time += delta * float_speed
	position = original_position + Vector2(
		sin(time + float_offset) * float_amplitude.x,
		cos(time * 0.7 + float_offset * 1.3) * float_amplitude.y
	)

func _on_hover_start() -> void:
	# Only start if not already scaling up
	if active_tween and active_tween.is_running():
		active_tween.kill()

	active_tween = create_tween()
	active_tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	active_tween.tween_property(self, "scale", original_scale * hover_scale, hover_time)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_hover_end() -> void:
	# Only start if not already scaling down
	if active_tween and active_tween.is_running():
		active_tween.kill()

	active_tween = create_tween()
	active_tween.set_process_mode(Tween.TWEEN_PROCESS_IDLE)
	active_tween.tween_property(self, "scale", original_scale, hover_time)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _exit_tree() -> void:
	if active_tween and is_instance_valid(active_tween):
		active_tween.kill()


func _on_button_Menu_pressed() -> void:
	
	pass # Replace with function body.
