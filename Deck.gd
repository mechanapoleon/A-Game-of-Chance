extends Control

@export var deck_texture: Texture = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardTexture = $DeckTexture
	cardTexture.texture = deck_texture
	cardTexture.size = Vector2(120, 180)  # Dimensioni visibili


func _on_Button_mouse_entered():
	var cardTexture = $CardTexture
	if cardTexture:
		cardTexture.modulate = Color(0.8, 0.8, 0.8)  # Change the texture color when mouse enters

func _on_Button_mouse_exited():
	var cardTexture = $CardTexture
	if cardTexture:
		cardTexture.modulate = Color(1, 1, 1)  # Reset the texture color when mouse exits


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
