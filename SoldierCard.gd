extends Sprite2D 

#chiama delle funzioni da DialoguePanel per interagire con la dialogue box
signal cardClicked(dialogKey: String, flag: bool)
 

# Variabili per memorizzare la posizione originale e l'illuminazione della carta
var original_position
var original_modulate

var center_position = Vector2(500, 240)

# Funzione chiamata quando la scena viene avviata
func _ready():
	original_position = position
	original_modulate = modulate
	# Connetti i segnali dell'Area2D alle funzioni corrispondenti
	$Area2D.mouse_entered.connect(self._on_mouse_entered)
	$Area2D.mouse_exited.connect(self._on_mouse_exited)
	$Area2D.input_event.connect(self._on_input_event)
	
# Funzione chiamata quando il mouse entra nell'area della carta
func _on_mouse_entered():
	# Illumina la carta aumentando il valore di modulate
	modulate = Color(1.2, 1.2, 1.2, 1.0)
	# Sposta la carta leggermente in avanti
	position.y -= 10

# Funzione chiamata quando il mouse esce dall'area della carta
func _on_mouse_exited():
	# Ripristina l'illuminazione e la posizione originale della carta
	modulate = original_modulate
	position = original_position

func _onDialogueTriggered(dialogueKey: String):
	# Esegui le azioni necessarie quando il dialogo è attivato
	# Puoi usare la chiave dialogueKey qui
	print("Dialogo attivato con chiave:", dialogueKey)
	

func _on_input_event(viewport, event, shape_idx):
	# Controlla se l'evento è un clic del mouse sinistro
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Avvia l'animazione di movimento della carta verso il centro del tabellone
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", center_position, 0.5)
#		print(dialoguePanelNode)
#		dialoguePanelNode.triggerDialogue("AfterYouMove")
		cardClicked.emit("AfterYouMove", true)		

	
