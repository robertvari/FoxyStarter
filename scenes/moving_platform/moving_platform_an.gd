extends Node2D

@export var offset: Vector2 = Vector2(0, -200)
@export var duration: float = 4.0
@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_tween()

func start_tween() -> void:
	var tween: Tween = create_tween()
	tween.set_loops()
	tween.tween_property(animatable_body_2d, "position", offset, duration / 2)
	tween.tween_property(animatable_body_2d, "position", Vector2.ZERO, duration / 2)
