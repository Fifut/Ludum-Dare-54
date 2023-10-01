extends Control


@onready var ScoreLabel : Label = %ScoreLabel


var orbiting_satellite: int = 0:
	set(value) :
		ScoreLabel.text = "Orbiting satellite : " + str(value)
