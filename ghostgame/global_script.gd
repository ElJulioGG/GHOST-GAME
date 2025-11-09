extends Node

var _globalRng : RandomNumberGenerator
var _currentSceneTree: SceneTree
var _currentScene : Node
var _currentPlayer : Player

func _ready() -> void:
	# New global rng
	_globalRng = RandomNumberGenerator.new()
	
	# Get the current scene treee and save it
	_currentSceneTree = get_tree()
	
	# Set the current scene to be the... current scene lule
	_currentScene = get_tree().current_scene
