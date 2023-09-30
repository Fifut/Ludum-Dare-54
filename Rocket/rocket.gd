extends RigidBody2D

@export var RCS_Force = 0.1
@export var Engine_Force = 1

@onready var EngineMarker = %EngineMarker
@onready var RCSMarker = %RCSMarker
@onready var FireSprite = %FireSprite
@onready var FireAudioStreamPlayer = %FireAudioStreamPlayer


var engine = 0.0


func _process(delta):
	if engine > 0 and not FireAudioStreamPlayer.playing:
		FireAudioStreamPlayer.play()
	elif engine == 0 and FireAudioStreamPlayer.playing:
		FireAudioStreamPlayer.stop()
		
	FireAudioStreamPlayer.pitch_scale = lerp(0.5, 1.0, engine / 100.0)

func _integrate_forces(state):
		if Input.is_action_pressed("Engine+"):
			engine += Engine_Force
			
		elif Input.is_action_pressed("Engine-"):
			engine -= Engine_Force
		
		
		if Input.is_action_pressed("Left"):
			angular_velocity -= RCS_Force
			
		elif Input.is_action_pressed("Right"):
			angular_velocity += RCS_Force
		
		if engine > 0:
			FireSprite.show()
		else:
			FireSprite.hide()
		
		EVENT.on_engine_power_change.emit(engine)
#		linear_velocity = (Vector2(0, -engine).rotated(rotation))
		
		engine = clampi(engine, 0, 100)
		
		var gravity = state.get_total_gravity() - (Vector2(0, engine).rotated(rotation))
		apply_central_force(gravity)



func remove():
	queue_free()
