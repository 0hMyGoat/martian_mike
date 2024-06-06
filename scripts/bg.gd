extends ParallaxBackground

@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Pink.png") as CompressedTexture2D
@export var IMAGE_SIZE: Vector2 = Vector2(64, 64)
@export var SCROLL_DIRECTION_PER_FRAME: Vector2 = Vector2(10, 10)

@onready var SPRITE: Sprite2D = $ParallaxLayer/Sprite2D

func _ready() -> void:
	SPRITE.texture = bg_texture

func _process(delta: float) -> void:
	SPRITE.region_rect.position += delta * SCROLL_DIRECTION_PER_FRAME
	if SPRITE.region_rect.position == IMAGE_SIZE:
		SPRITE.region_rect.position = Vector2.ZERO
