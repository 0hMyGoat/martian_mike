extends Node2D

class_name Level

@onready var SPAWN: Start = $Start
@onready var EXIT: Exit = $Exit
@onready var DEATH_ZONE: Area2D = $DeathZone
@onready var UI: Ui = $UI
@onready var HUD: Hud = $UI/HUD

@export var level_name: String = "Level 1"
@export var next_level: PackedScene = null
@export var level_time: int = 5

var PLAYER: PackedScene = preload("res://scenes/player.tscn")
var timer: Timer = null

func _ready() -> void:
	UI.show_win_screen(false)
	setup_timer()
	spawn_player()
	setup_traps()
	EXIT.body_entered.connect(_on_exit_entered)
	DEATH_ZONE.body_entered.connect(_on_death_zone_body_entered)


## When the timer runs out, reload the current scene
func _on_level_timeout() -> void:
	level_time -= 1
	print("Time left: ", level_time)
	HUD.set_time_label(level_time)
	if level_time < 0:
		get_tree().reload_current_scene()

## When the player enters the exit, animate the exit and change the scene
func _on_exit_entered(body: Player) -> void:
	timer.stop()
	EXIT.animate()
	if is_last_level():
		UI.show_win_screen(true)
	body.is_active = false
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_packed(next_level)

## When the player enters the death zone, respawn the player
func _on_death_zone_body_entered(body: Player) -> void:
	respawn(body)

## When a trap touches the player, respawn the player
func _on_trap_touched_player(player: Player) -> void:
	respawn(player)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		respawn(get_node("Player"))

func is_last_level() -> bool:
	return next_level == null

## Respawn the player at the spawn point
func respawn(player: Player) -> void:
	player.velocity = Vector2.ZERO
	player.global_position = SPAWN.get_spawn_pos()
	player.is_active = true
	player.play_hurt_sound()

## Spawn the player at the spawn point at the start of the level
func spawn_player() -> void:
	var player_instance: Player = PLAYER.instantiate()
	add_child(player_instance)
	player_instance.is_active = true
	player_instance.global_position = SPAWN.get_spawn_pos()

## Setup the timer for the level and start it
func setup_timer() -> void:
	HUD.set_time_label(level_time)
	timer = Timer.new()
	timer.name = "Level Timer"
	timer.wait_time = 1
	timer.timeout.connect(_on_level_timeout)
	add_child(timer)
	timer.start()

## Setup the traps in the level
func setup_traps() -> void:
	var traps: Array[Variant] = get_tree().get_nodes_in_group("traps")
	for trap: Trap in traps:
		#OLD WAY : trap.connect("touched_player", _on_trap_touched_player)
		trap.touched_player.connect(_on_trap_touched_player)
