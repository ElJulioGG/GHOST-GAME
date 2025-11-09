# AnimationComponent.gd (FINAL - SIN ERRORES AL CAMBIAR ESCENA)
class_name AnimationComponent extends Node

@export var from_center: bool = true
@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var time: float = 0.15
@export var transition_type: Tween.TransitionType = Tween.TRANS_CUBIC

var target: Control
var default_scale: Vector2

func _ready() -> void:
	target = get_parent() as Control
	if not target:
		push_error("AnimationComponent debe ser hijo de un Control")
		return
	
	call_deferred("setup")

func setup() -> void:
	if not is_inside_tree():
		return
		
	if from_center:
		target.pivot_offset = target.size / 2
	default_scale = target.scale
	
	connect_signals()

func connect_signals() -> void:
	if target:
		target.mouse_entered.connect(on_hover)
		target.mouse_exited.connect(off_hover)

func on_hover() -> void:
	add_tween("scale", hover_scale, time)

func off_hover() -> void:
	add_tween("scale", default_scale, time)

# === ANTI-ERRORES AL CAMBIAR ESCENA ===
func add_tween(property: String, value: Variant, seconds: float) -> void:
	# VERIFICACIONES CRÍTICAS
	if not is_inside_tree():
		return
	if not target:
		return
	if not get_tree():
		return
		
	var tween = get_tree().create_tween()
	if tween:
		tween.tween_property(target, property, value, seconds)\
			.set_trans(transition_type)
