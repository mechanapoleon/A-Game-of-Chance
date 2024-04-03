extends Button

var isFaceUp = false
var cardContent := "Contenuto della carta" # Sostituisci con il contenuto effettivo della carta
var cardNumber: int = -1  # Numero unico associato a ciascuna carta, -1 di default
var card_texture_back = preload("res://Images/LocationCards/loc1back.png")
var card_texture_front = preload("res://Images/LocationCards/loc1front.png")




func _ready():
	var upperLeftTexture = $UpperLeftTexture
	if upperLeftTexture:
		print("Setting initial texture")
		upperLeftTexture.texture = card_texture_back
	flipCard()

func _on_Button_pressed():
	flipCard()

func flipCard():
	print("Flipping card")
	print("isFaceUp: " + str(isFaceUp))
	isFaceUp = !isFaceUp
	update_card_visual()

func update_card_visual():
	# Modifica l'aspetto visivo della carta in base a is_face_up
	print("Updating card visual")
	print("isFaceUp: " + str(isFaceUp))
	if isFaceUp:
		# Mostriamo il contenuto della carta
		self.custom_minimum_size = Vector2(75, 75)  # Dimensioni visibili
		self.modulate = Color(1, 1, 1)  # Colore normale
		var upperLeftTexture = $UpperLeftTexture
		if upperLeftTexture:
			print("Setting front texture")
			upperLeftTexture.texture = card_texture_front
#			upperLeftTexture.custom_min_size = Vector2(75, 75) #fissa le dimensioni dell'immagine
	else:
		# Copriamo la carta
		self.custom_minimum_size = Vector2(75, 75)  # Dimensioni ridotte
		self.modulate = Color(0.5, 0.5, 0.5)  # Colore grigio scuro o altro colore per indicare copertura
		$UpperLocationLeftCard.bbcode_text = "Carta " 
		var upperLeftTexture = $UpperLeftTexture
		if upperLeftTexture:
			print("Setting back texture")
			upperLeftTexture.texture = card_texture_back
#			upperLeftTexture.custom_min_size = Vector2(75, 75) #fissa le dimensioni dell'immagine

		# Puoi anche aggiungere un'animazione qui

# Nuovo metodo per impostare il numero della carta
func set_card_number(number: int):
	cardNumber = number
