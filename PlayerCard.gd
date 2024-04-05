extends Button

@export var player_card_texture: Texture = null

var original_position = position
var original_modulate = modulate

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardTexture = $PlayerCardTexture
	original_position = position
	original_modulate = modulate	
	if cardTexture:
		print("Setting player card texture")
		cardTexture.texture = player_card_texture
		cardTexture.size = Vector2(120, 180)  # Dimensioni visibili


func _on_Button_mouse_entered():
	var cardTexture = $PlayerCardTexture
	if cardTexture:
		cardTexture.modulate = Color(0.8, 0.8, 0.8)  # Change the texture color when mouse enters
		position.y -= 10

func _on_Button_mouse_exited():
	var cardTexture = $PlayerCardTexture
	if cardTexture:
		position = original_position
		cardTexture.modulate = Color(1, 1, 1)  # Reset the texture color when mouse exits


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
