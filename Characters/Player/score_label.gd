extends Label

var default_text = "Score: "

func _process(_delta):
	var score_text = str(default_text, VariablesGlobal.current_score)
	self.text = score_text
