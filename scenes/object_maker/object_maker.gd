extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.spawn_scene.connect(on_spawn_scene)
	SignalHub.spawn_bullet.connect(on_spawn_pullet)

func on_spawn_pullet(velocity: Vector2, start_pos: Vector2, scene: PackedScene) -> void:
	if !scene: return
	var nb = scene.instantiate()
	nb.setup(velocity, start_pos)
	add_child.call_deferred(nb)

func on_spawn_scene(pos: Vector2, scene: PackedScene) -> void:
	if !scene: return
	var ns = scene.instantiate()
	
	if ns is Node2D:
		ns.global_position = pos
	
	add_child.call_deferred(ns)
