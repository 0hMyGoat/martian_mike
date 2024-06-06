extends Node2D
class_name Trap

signal touched_player(player: Player)

func _on_area_2d_body_entered(body: Node) -> void:
	if body is Player:
		touched_player.emit(body)