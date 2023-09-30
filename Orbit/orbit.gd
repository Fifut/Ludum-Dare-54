extends Node2D

signal on_orbit_area_overlapping

@onready var OrbitArea = %OrbitArea
@onready var TimerArea : Timer = %TimerArea


var area


func _on_orbit_area_area_entered(area):
	TimerArea.start()
	self.area = area
	


func _on_orbit_area_area_exited(area):
	on_orbit_area_overlapping.emit(null)
	TimerArea.stop()
	self.area = null


func _on_timer_timeout():
	on_orbit_area_overlapping.emit(area)
