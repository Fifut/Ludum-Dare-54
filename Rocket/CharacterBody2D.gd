extends RigidBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _integrate_forces(state):
	
	var gravity = state.get_total_gravity()
	
	state.set_constant_force(gravity)

