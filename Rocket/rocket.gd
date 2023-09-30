extends RigidBody2D


signal on_rocket_at_orbit


@export var RCS_Force = 0.1
@export var Engine_Force = 1
@export var Fuel = 100

@onready var EngineMarker = %EngineMarker
@onready var RCSMarker = %RCSMarker
@onready var FireSprite = %FireSprite
@onready var FireAudioStreamPlayer = %FireAudioStreamPlayer
@onready var OrbitTimer : Timer = %OrbitTimer
@onready var OrbitProgressBar : TextureProgressBar = %OrbitProgressBar


var engine = 0.0


func _ready():
	EVENT.on_engine_fuel_change.emit(Fuel)
	
	OrbitProgressBar.hide()
	OrbitProgressBar.min_value = 0
	OrbitProgressBar.max_value = OrbitTimer.wait_time



func _process(delta):
	# Engine sound
	if engine > 0 and not FireAudioStreamPlayer.playing:
		FireAudioStreamPlayer.play()
	elif engine == 0 and FireAudioStreamPlayer.playing:
		FireAudioStreamPlayer.stop()
		
	FireAudioStreamPlayer.pitch_scale = lerp(0.5, 1.0, engine / 100.0)
	
	#Orbit progressbar
	if not OrbitTimer.is_stopped():
		OrbitProgressBar.show()
		OrbitProgressBar.value = OrbitProgressBar.max_value - OrbitTimer.time_left
	else:
		OrbitProgressBar.hide()
	
	# Fire sprite
	if engine > 0:
		FireSprite.show()
	else:
		FireSprite.hide()
	
	#Fuel
	if engine > 0:
		Fuel -= (engine/1000.0)
		EVENT.on_engine_fuel_change.emit(Fuel)



func _integrate_forces(state):
		if Input.is_action_pressed("Engine+"):
			engine += Engine_Force
			
		elif Input.is_action_pressed("Engine-"):
			engine -= Engine_Force
		
		
		if Input.is_action_pressed("Left"):
			angular_velocity -= RCS_Force
			
		elif Input.is_action_pressed("Right"):
			angular_velocity += RCS_Force
		
		engine = clampi(engine, 0, 100)
		
		if Fuel < 0:
			engine = 0
		
		EVENT.on_engine_power_change.emit(engine)
		
		var gravity = state.get_total_gravity() - (Vector2(0, engine).rotated(rotation))
		apply_central_force(gravity)


func _on_orbit_area_entered(_area):
	OrbitTimer.start()


func _on_orbit_area_exited(_area):
	OrbitTimer.stop()


func _on_orbit_timer_timeout():
	on_rocket_at_orbit.emit(self.global_position, self.global_rotation_degrees)
	queue_free()
