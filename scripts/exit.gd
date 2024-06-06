extends Area2D
class_name Exit

@onready var ANIMATED_SPRITE: AnimatedSprite2D = $AnimatedSprite2D

func animate():
    ANIMATED_SPRITE.play("end")