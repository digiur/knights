extends RigidBody2D

@export var timerPath: NodePath

@export var force: float = 15000.0

var airTimer: Timer

var lastNormal: Vector2 = Vector2.ZERO

func _init():
	set_inertia(1.0)

func _ready():
	airTimer = get_node(timerPath)

func _physics_process(delta):
	print(lastNormal)

func _input(event):
	if event.is_action_pressed("player_jump"):
		jump()

func _integrate_forces(state):

	var normal : Vector2 = Vector2.ZERO

	if state.get_contact_count() > 0:
		for i in state.get_contact_count():
			normal += state.get_contact_local_normal(i)
		normal = normal.normalized()
		lastNormal = normal
		airTimer.start()
	else:
		normal = lastNormal

	if Input.is_action_pressed("player_right"):
		apply_force(force * Vector2(-normal.y, normal.x))

	elif Input.is_action_pressed("player_left"):
		apply_force(force * Vector2(normal.y, -normal.x))

func jump():
	print(get_inertia())

func _on_timer_timeout():
	lastNormal = Vector2.ZERO
