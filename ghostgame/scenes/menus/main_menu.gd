extends Control

@onready var panel_main = $PanelPrincipal
@onready var panel_instrucciones = $PanelInstrucciones
@onready var panel_creditos = $PanelCreditos

# === MÚSICA DE FONDO ===
@export var music_path: String = "res://Assets/sounds/menu.ogg"  # Tu música aquí
var music_player: AudioStreamPlayer

func _ready():
	_show_panel(panel_main)
	_play_menu_music()

# === REPRODUCIR MÚSICA AL INICIO ===
func _play_menu_music():
	if music_path == "":
		return
	
	music_player = AudioStreamPlayer.new()
	music_player.stream = load(music_path)
	music_player.volume_db = -2  # Volumen suave
	music_player.autoplay = true
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS  # Sigue sonando al cambiar escena
	
	# LOOP infinito
	if music_player.stream:
		music_player.finished.connect(func(): 
			music_player.play()
		)
	
	add_child(music_player)
	music_player.play()

# === PARAR MÚSICA (Play / Exit) ===
func _stop_menu_music():
	if music_player and is_instance_valid(music_player):
		music_player.stop()
		music_player.queue_free()
		music_player = null

# Utility function to show only one panel at a time
func _show_panel(panel_to_show: Control):
	panel_main.visible = false
	panel_instrucciones.visible = false
	panel_creditos.visible = false
	panel_to_show.visible = true

# === BOTONES ===
func _on_Play_pressed() -> void:
	_stop_menu_music()  # PARAR MÚSICA
	get_tree().change_scene_to_file("res://Scenes/player/player_scene.tscn")

func _on_Instrucciones_pressed() -> void:
	_show_panel(panel_instrucciones)

func _on_Creditos_pressed() -> void:
	_show_panel(panel_creditos)

func _on_Exit_pressed() -> void:
	_stop_menu_music()  # PARAR MÚSICA
	get_tree().quit()

func _on_button_close_pressed() -> void:
	_show_panel(panel_main)

func _on_button_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menus/main_menu.tscn")
