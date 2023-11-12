extends Node2D


## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#

var lifePoints := 0
var mana := 10
var sanity := 0

func _ready():
	aggiorna_UI()

func aggiorna_UI():
	$Sheet/LifePointsLabel.text = "life points " + str(lifePoints)
	$Sheet/ManaLabel.text = "mana " + str(mana)
	$Sheet/SanityLabel.text = "sanity " + str(sanity)
	
func _on_Button_Mana_pressed():
	mana += 10 
	aggiorna_UI()

func _on_Button_PuntiVita_pressed():
	lifePoints += 5  
	aggiorna_UI()

func _on_Button_Nemici_pressed():
	sanity += 1  
	aggiorna_UI()
	


func _on_play_card_button_pressed():
	mana -= 1 
	sanity -= 1 
	aggiorna_UI()
	
