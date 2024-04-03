extends Control

@export var dialoguePath = "res://Dialogues/sampleDialogue.json"
@export var textSpeed = 0.05

@export var soldierCardPath = "/root/FirstScene/SoldierCard"

var dialogue: Array
var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	var soldierNode = get_node(soldierCardPath)
	soldierNode.cardClicked.connect(_triggerDialogue)
	dialogue = getDialogue()
	if dialogue.is_empty():
		print("Dialogue not found or is empty")
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

func getDialogue() -> Array:
	var file := FileAccess.open(dialoguePath, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		file.close()
		var json = JSON.new()
		var error = json.parse(json_text)
		if error == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_DICTIONARY or typeof(data_received) == TYPE_ARRAY:
				return data_received
			else:
				print("Unexpected data type: ", typeof(data_received))
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_text, " at line ", json.get_error_line())
	else:
		print("Failed to open file: ", dialoguePath)
	return []



func nextPhrase() -> void:
	print(dialogue.size())
	if phraseNum >= dialogue.size():
		queue_free()
		return

	finished = false
	print("phraseNum: " + str(phraseNum))
	print(dialogue[phraseNum])
	var current_phrase = dialogue[phraseNum]
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


func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()
	var finish = json.parse_string(content)
	return finish

func _triggerDialogue(dialogueKey: String, flag: bool):
	print("triggered dialogue")
	var jsonData = readJSON(dialoguePath)
	
	for entry in jsonData:
		print("dialogkey: ", entry["dialogueKey"])
		if entry["dialogueKey"] == dialogueKey:
			var character = entry["character"]
			var thisDialogue = entry["dialogue"]
			var emotion = entry["emotion"]

			print("found dialogue for this key")
			print("character: ", character, "dialogue: ", thisDialogue, "emotion: ", emotion)	 			
			$Name.bbcode_text = character
			$TextBox.bbcode_text = thisDialogue
			$TextBox.visible_characters = 0
			$Timer.start()
			var img_path = "res://images/characterPics/" + entry["character"] + entry["emotion"] + ".png"
			print(img_path)
			if ResourceLoader.exists(img_path):
				$Portrait.texture = load(img_path)
			else:
				$Portrait.texture = null
		else:
			print("didn't find dialogue for this key")
	return []

			

func _on_Timer_timeout():
	if $TextBox.visible_characters < $TextBox.text.length():
		$TextBox.visible_characters += 1
	else:
		finished = true
		$Timer.stop()
