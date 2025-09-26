extends Node2D

@export var speed: float = -220.0

@onready var gate: Area2D      = $ScoreGate
@onready var top_body: Node    = $PipeTop
@onready var bottom_body: Node = $PipeBottom

func _ready() -> void:
	if is_instance_valid(top_body):    top_body.add_to_group("pipe")
	if is_instance_valid(bottom_body): bottom_body.add_to_group("pipe")

	gate.monitoring = true
	gate.monitorable = true
	if not gate.body_entered.is_connected(Callable(self, "_on_gate_body_entered")):
		gate.body_entered.connect(Callable(self, "_on_gate_body_entered"))

	var cs: CollisionShape2D = gate.get_node("CollisionShape2D")
	if cs.shape == null:
		cs.shape = RectangleShape2D.new()
		(cs.shape as RectangleShape2D).size = Vector2(260, 300)
	cs.disabled = false

func _physics_process(delta: float) -> void:
	if GameState.is_dead:
		queue_free()
		return
	position.x += speed * delta
	if position.x < -300.0:
		queue_free()

func _on_gate_body_entered(body: Node2D) -> void:
	if GameState.is_dead: return
	if body is CharacterBody2D and body.name == "Bird":
		GameState.add_point(1)
		gate.queue_free()
