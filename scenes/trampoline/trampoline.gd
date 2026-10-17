class_name Trampoline
extends Area2D
@export var bounce_velocity: Vector2 = Vector2(0, -400)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound: AudioStreamPlayer = $Sound

var bouncing: bool:
	get: return animated_sprite_2d.is_playing()

func bounce() -> void:
	sound.play()
	animated_sprite_2d.play()
