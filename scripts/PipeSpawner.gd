extends Node

@export var interval: float = 1.6
var running := false
@onready var timer: Timer = get_node_or_null("Timer")

func _ready() -> void:
	if timer == null:
		timer = Timer.new()
		timer.name = "Timer"
		add_child(timer)
	timer.autostart = false
	timer.one_shot = false
	timer.wait_time = interval
	if not timer.timeout.is_connected(Callable(self, "_spawn_pair")):
		timer.timeout.connect(Callable(self, "_spawn_pair"))

func start() -> void:
	if running: return
	running = true
	_spawn_pair()
	timer.start()

func reset() -> void:
	running = false
	timer.stop()

func stop() -> void:
	reset()

func _spawn_pair() -> void:
	if not running: return
	var pair := preload("res://scenes/PipePair.tscn").instantiate()
	get_tree().current_scene.add_child(pair)
	var vp := get_viewport().get_visible_rect().size
	pair.global_position = Vector2(vp.x + 100.0, randf_range(120.0, vp.y - 120.0))
