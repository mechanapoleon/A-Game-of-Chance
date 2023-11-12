extends Control

@export var dialogPath = "res://Dialogues/sampleDialogue.json"
@export var textSpeed = 0.05

var dialog: Array
var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	if dialog.is_empty():
		print("Dialog not found or is empty")
		queue_free()
	else:
		nextPhrase()
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))


func _process(_delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$TextBox.visible_characters = $TextBox.text.length()

func getDialog() -> Array:
	var file := FileAccess.open(dialogPath, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		file.close()
		var json = JSON.new()
		var error = json.parse(json_text)
		print(json_text)
		if error == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_DICTIONARY or typeof(data_received) == TYPE_ARRAY:
				return data_received
			else:
				print("Unexpected data type: ", typeof(data_received))
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_text, " at line ", json.get_error_line())
	else:
		print("Failed to open file: ", dialogPath)
	return []



func nextPhrase() -> void:
	print(dialog.size())
	if phraseNum >= dialog.size():
		queue_free()
		return

	finished = false
	print("phraseNum: " + str(phraseNum))
	print(dialog[phraseNum])
	var current_phrase = dialog[phraseNum]
	print(current_phrase["character"])
	$Name.bbcode_text = current_phrase["character"]
	print(current_phrase["dialogue"])
	$TextBox.bbcode_text = current_phrase["dialogue"]
	$TextBox.visible_characters = 0
	$Timer.start()
	
	var img_path = "res://images/characterPics/" + current_phrase["character"] + current_phrase["emotion"] + ".png"
	print(img_path)
	if ResourceLoader.exists(img_path):
		$Portrait.texture = load(img_path)
	else:
		$Portrait.texture = null
	phraseNum += 1

func _on_Timer_timeout():
	if $TextBox.visible_characters < $TextBox.text.length():
		$TextBox.visible_characters += 1
	else:
		finished = true
		$Timer.stop()
