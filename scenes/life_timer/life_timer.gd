extends Node

@onready var timer: Timer = $Timer
@export var lifetime: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(lifetime)


func _on_timer_timeout() -> void:
	get_parent().queue_free()
