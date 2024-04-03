extends Control

const spacingBetweenCards = 10
const cardSize = Vector2(125, 125)



# Called when the node enters the scene tree for the first time.
func _ready():
	positionAndSizeCards()

 
func positionAndSizeCards():
	var gridSize = Vector2(cardSize.x * 2 + spacingBetweenCards, cardSize.y * 2 + spacingBetweenCards)
	
	# Calcola la posizione iniziale per centrare la griglia
	var initialPosition = Vector2((get_viewport_rect().size.x/4 - gridSize.x) / 2, (get_viewport_rect().size.y/4 - gridSize.y) / 4)
	print("initialPosition")
	print(initialPosition)
	
	for i in range(4):
		var cardNames = ["UpperLeftLocationCard", "UpperRightLocationCard", "LowerLeftLocationCard", "LowerRightLocationCard"]
	
		if i < cardNames.size():
			var cardName = cardNames[i]
#			print("cardName: " + cardName)
			var card = get_node("./" + cardName)  # Modifica con il nome reale del tuo nodo genitore della griglia		
#			print("card")
#			print(card)
			var row: int = i / 2  # Divisione intera per ottenere la riga (0 o 1)
			var col: int = i % 2   # Resto della divisione per ottenere la colonna (0 o 1)

			# Calcola la posizione della carta all'interno della griglia
			var cardPosition = initialPosition + Vector2(col * (cardSize.x + spacingBetweenCards), row * (cardSize.y + spacingBetweenCards))
#			print("cardSize")
#			print(cardSize)
			# Imposta la posizione e le dimensioni della carta
			card.custom_minimum_size = cardSize
			card.position = cardPosition
		else:
			print("Errore: numero di carta non valido")
