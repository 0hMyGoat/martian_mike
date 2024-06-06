extends StaticBody2D
class_name Start

@onready var SPAWN_POS: Marker2D = $SpawnPosition

func get_spawn_pos() -> Vector2:
	return SPAWN_POS.global_position