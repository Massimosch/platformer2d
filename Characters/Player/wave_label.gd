extends Label

var default_text = "Wave: "


func _process(_delta):
	var wave_text = str(default_text, VariablesGlobal.current_wave)
	self.text = wave_text
