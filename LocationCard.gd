extends Button

var isFaceUp = false
var cardContent := "Contenuto della carta" # Sostituisci con il contenuto effettivo della carta

@export var cardNumber: int = -1  # Numero unico associato a ciascuna carta, -1 di default
@export var card_texture_back: Texture = null
@export var card_texture_front: Texture = null

func _ready():
	var cardTexture = $CardTexture
	if cardTexture:
		print("Setting initial texture")
		cardTexture.texture = card_texture_back
		cardTexture.size = Vector2(150, 150)  # Dimensioni visibili
#	flipCard()

func _on_Button_mouse_entered():
	var cardTexture = $CardTexture
	if cardTexture:
		cardTexture.modulate = Color(0.8, 0.8, 0.8)  # Change the texture color when mouse enters

func _on_Button_mouse_exited():
	var cardTexture = $CardTexture
	if cardTexture:
		cardTexture.modulate = Color(1, 1, 1)  # Reset the texture color when mouse exits
			
func _on_Button_pressed():
	flipCard()

func flipCard():
	print("Flipping card")
	print("isFaceUp: " + str(isFaceUp))
	$CardTexture.modulate = Color(1, 1, 1)  # Reset the texture color when mouse exits
	isFaceUp = !isFaceUp
	update_card_visual()

func update_card_visual():
	print("Updating card visual")
	print("isFaceUp: " + str(isFaceUp))
	if isFaceUp:
		var cardTexture = $CardTexture
		if cardTexture:
			print("Setting front texture")
			cardTexture.texture = card_texture_front
			cardTexture.size = Vector2(150, 150)  # Dimensioni visibili
	else:
		var cardTexture = $CardTexture
		if cardTexture:
			print("Setting back texture")
			cardTexture.texture = card_texture_back
			cardTexture.size = Vector2(150, 150)  # Dimensioni visibili	

		# Puoi anche aggiungere un'animazione qui
