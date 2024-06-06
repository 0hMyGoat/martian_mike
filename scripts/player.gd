extends CharacterBody2D
class_name Player

@onready var ANIMATIONS: AnimatedSprite2D = $AnimatedSprite2D
@onready var JUMP_SOUND: AudioStreamPlayer2D = $SoundEffects/JumpSound
@onready var HURT_SOUND: AudioStreamPlayer2D = $SoundEffects/HurtSound

@export var GRAVITY: int = 400
@export var SPEED: int = 125
@export var JUMP_FORCE: int = 200

var is_active: bool = true
var direction: float

func _physics_process(delta: float) -> void:

	if !is_on_floor():
		if velocity.y > 500:
			return
		velocity.y += GRAVITY * delta

	if is_active:
		if Input.is_action_just_pressed("jump") && is_on_floor():
			jump(JUMP_FORCE)

		direction = Input.get_axis("move_left", "move_right")

		if direction != 0:
			ANIMATIONS.flip_h = direction == -1
	else:
		direction = 0

	velocity.x = direction * SPEED
	update_animations(direction)
	move_and_slide()


func update_animations(direction: float) -> void:
	if is_on_floor():
		if direction == 0:
			ANIMATIONS.play("idle")
		else:
			ANIMATIONS.play("run")
	else:
		if velocity.y < 0:
			ANIMATIONS.play("jump")
		else:
			ANIMATIONS.play("fall")

func jump(force: float) -> void:
	velocity.y = -force
	play_jump_sound()

func play_jump_sound() -> void:
	JUMP_SOUND.play()

func play_hurt_sound() -> void:
	HURT_SOUND.play()