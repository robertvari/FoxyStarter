extends Node2D

@export var bullet_scene: PackedScene
@export var bullet_speed: float = 80.0
@export var shoot_time: float = 3.0

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var muzzle: Marker2D = $Muzzle
@onready var sound: AudioStreamPlayer2D = $Sound

var _player_ref: Player

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if !_player_ref:
		push_error("NO player found by Plant")
		queue_free()
		
func _process(_delta: float) -> void:
	var flip: bool = _player_ref.global_position.x > global_position.x
	if flip != sprite_2d.flip_h:
		sprite_2d.flip_h = flip
		muzzle.position.x *= -1
		

func shoot() -> void:
	if !bullet_scene: return
	sound.play()
	var dir: Vector2 = muzzle.global_position.direction_to(_player_ref.global_position)
	SignalHub.emit_spawn_pullet(dir * bullet_speed, muzzle.global_position, bullet_scene)

func start_timer() -> void:
	timer.start(shoot_time * randf_range(0.8, 1.2))

func _on_timer_timeout() -> void:
	animation_player.play("shoot")

func _on_screen_entered() -> void:
	start_timer()

func _on_screen_exited() -> void:
	timer.stop()

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shoot":
		animation_player.play("idle")
		start_timer()
