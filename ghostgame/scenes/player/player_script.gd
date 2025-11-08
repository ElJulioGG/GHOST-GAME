class_name Player
extends CharacterBody2D

@export_category("Nodes")
@export var _hitbox : CollisionShape2D 
@export var _animSprite : AnimatedSprite2D
@export var _rcUp : RayCast2D
@export var _rcDown : RayCast2D
@export var _rcRight : RayCast2D
@export var _rcLeft : RayCast2D

const _gridSize : float = 32
var _movementTween : Tween

var _canInteract : bool = true
var _currentInteractable : Interactable = null

################################ Visual ################################

func _look_at_direction(dir : String) -> void:
	
	# 4 WAY ELIF STATEMENT
	# play a certain animation (up, down, left or right)
	# based on the dir string!!!
	
	pass

################################ Interactions ################################

func _set_interactable(obj : Interactable) -> void:
	_currentInteractable = obj

func _clear_interactable(obj : Interactable) -> void:
	if obj == _currentInteractable:
		_currentInteractable = null

func _check_interaction() -> void:
	if !_movementTween or !_movementTween.is_running():
		if Input.is_action_just_pressed("interaction") && _canInteract && _currentInteractable != null:
			_currentInteractable._interaction()

################################ Movement functions ################################

func _calculate_movement() -> void:
	if !_movementTween or !_movementTween.is_running():
		if Input.is_action_pressed("move_up") && !_rcUp.is_colliding():
			_move(Vector2(0,-1))
		elif Input.is_action_pressed("move_down") && !_rcDown.is_colliding():
			_move(Vector2(0,1))
		elif Input.is_action_pressed("move_left") && !_rcLeft.is_colliding():
			_move(Vector2(-1,0))
		elif Input.is_action_pressed("move_right") && !_rcRight.is_colliding():
			_move(Vector2(1,0))

func _move(dir : Vector2) -> void:
	if _movementTween:
		_movementTween.kill()
	
	dir = dir * _gridSize
	
	_movementTween = create_tween()
	_movementTween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_movementTween.tween_property(self,"global_position",self.global_position + dir, 0.2).set_trans(Tween.TRANS_SINE)

################################# Physics Process #################################

func _physics_process(delta: float) -> void:
	_calculate_movement()
	_check_interaction()
