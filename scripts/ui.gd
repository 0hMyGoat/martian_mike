extends CanvasLayer
class_name Ui

@onready var WIN_SCREEN: WinScreen = $WinScreen

func show_win_screen(show: bool):
	WIN_SCREEN.visible = show