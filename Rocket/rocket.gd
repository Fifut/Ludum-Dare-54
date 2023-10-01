extends RigidBody2D


signal on_rocket_at_orbit
signal on_rocket_fail


@export var RCS_Force = 0.1
@export var Engine_Force = 1
@export var Fuel = 100

@onready var RocketSprite = %RocketSprite
@onready var RocketCollisionShape2D = %RocketCollisionShape2D
@onready var EngineMarker = %EngineMarker
@onready var RCSMarker = %RCSMarker
@onready var FireSprite = %FireSprite
@onready var FireAudioStreamPlayer = %FireAudioStreamPlayer
@onready var OrbitTimer : Timer = %OrbitTimer
@onready var OrbitProgressBar : TextureProgressBar = %OrbitProgressBar
@onready var RocketCPUParticles : CPUParticles2D = %RocketCPUParticles
@onready var SmokeParticles : CPUParticles2D = %SmokeParticles
@onready var ExplodeAudioStreamPlayer : AudioStreamPlayer = %ExplodeAudioStreamPlayer
@onready var OrbitArea2D : Area2D = %OrbitArea2D


var engine = 0.0


func _ready():
	EVENT.on_engine_fuel_change.emit(Fuel)
	
	OrbitTimer.wait_time = randf_range(1.0, 3.0)
#	OrbitTimer.wait_time = 0.1
	
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
		SmokeParticles.emitting = true
		SmokeParticles.initial_velocity_min = engine
		SmokeParticles.initial_velocity_max = engine
	else:
		FireSprite.hide()
		SmokeParticles.emitting = false
	
	#Fuel
	if engine > 0:
		Fuel -= (engine/1000.0)
		EVENT.on_engine_fuel_change.emit(Fuel)



func _integrate_forces(state):
		if Input.is_action_pressed("Engine+"):
			engine += Engine_Force
			
		elif Input.is_action_pressed("Engine-"):
			engine -= Engine_Force
		
		elif  Input.is_action_just_pressed("EngineOff"):
			engine = 0
		
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


func _on_collision_area_body_entered(_body):
	set_process(false)
	SmokeParticles.emitting = false
	FireAudioStreamPlayer.stop()
	OrbitProgressBar.hide()
	RocketSprite.hide()
	OrbitArea2D.set_deferred("monitoring", false)
	OrbitArea2D.set_deferred("monitorable", false)
	
	RocketCPUParticles.emitting = true
	ExplodeAudioStreamPlayer.play()
	await ExplodeAudioStreamPlayer.finished
	on_rocket_fail.emit()
	queue_free()
	
