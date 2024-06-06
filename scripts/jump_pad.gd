extends Area2D

@onready var ANIMATION: AnimatedSprite2D = $AnimatedSprite2D
@export var JUMP_FORCE: int = 300

func _on_body_entered(body: Player) -> void:
    ANIMATION.play("jump")
    body.jump(JUMP_FORCE)
