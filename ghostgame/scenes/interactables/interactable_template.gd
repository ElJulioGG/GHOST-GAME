class_name Interactable
extends Area2D

@export_category("Nodes")
@export var _hitbox : CollisionShape2D 
@export var _animSprite : AnimatedSprite2D

@export_category("Variables")
@export var _canInteract : bool = true
var _whenInteracted : Callable = _debug_interaction

func _debug_interaction() -> void:
	print("This message shouldn't appear. If it does, feel free to mutilate the lead programmer's balls")

func _on_body_entered(body: Node2D) -> void:
	if is_instance_of(body,Player):
		body._set_interactable(self)

func _on_body_exited(body: Node2D) -> void:
	if is_instance_of(body,Player):
		body._clear_interactable(self)

func _interaction() -> void:
	if _canInteract:
		_canInteract = false
		_whenInteracted.call()
