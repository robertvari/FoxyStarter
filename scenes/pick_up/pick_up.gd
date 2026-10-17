extends Area2D

@onready var sound: AudioStreamPlayer = $Sound
@onready var anim: AnimatedSprite2D = $Anim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.animation = (anim.sprite_frames.get_animation_names() as Array[String]).pick_random()
	anim.play()

func _on_body_entered(_body: Node2D) -> void:
	hide()
	sound.play()


func _on_sound_finished() -> void:
	queue_free()


func _on_collect_timer_timeout() -> void:
	monitoring = true
