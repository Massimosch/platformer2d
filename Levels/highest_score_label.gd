extends Label

var default_text = "Highest Score: "

func _process(_delta):
	var high_score_text = str(default_text, VariablesGlobal.high_score)
	self.text = high_score_text
