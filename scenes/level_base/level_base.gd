extends Node

const EXPLOSION = preload("uid://chwdw5gyttwbv")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		var ex: Node2D = EXPLOSION.instantiate()
		ex.position = Vector2(100, 500)
		add_child(ex)
