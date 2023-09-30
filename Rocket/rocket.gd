extends RigidBody2D

@export var RCS_Force = 0.1
@export var Engine_Force = 0.1

@onready var EngineMarker = %EngineMarker
@onready var RCSMarker = %RCSMarker

var engine = 0



func _integrate_forces(state):
		if Input.is_action_pressed("Engine+"):
			engine += Engine_Force
			
		elif Input.is_action_pressed("Engine-"):
			engine -= Engine_Force
		
		
		if Input.is_action_pressed("Left"):
			angular_velocity -= RCS_Force
			
		elif Input.is_action_pressed("Right"):
			angular_velocity += RCS_Force
		
		
		EVENT.on_engine_power_change.emit(engine)
		linear_velocity = (Vector2(0, -engine).rotated(rotation))
		
