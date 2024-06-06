extends Control
class_name Hud

func set_time_label(value: int) -> void:
	$TimeLabel.text = "TIME: " +  str(value)