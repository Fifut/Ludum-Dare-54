extends HBoxContainer


var num : int = 0:
	set(value):
		self.name = "Lead" + str(value)
		if value < 10:
			%Num.text = "0" + str(value) + ":"
		else:
			%Num.text = str(value) + ":"


var pts : int = 0:
	set(value):
		%Pts.text = str(value)


var lead_name : String = " ":
	set(value):
		%Name.text = value
