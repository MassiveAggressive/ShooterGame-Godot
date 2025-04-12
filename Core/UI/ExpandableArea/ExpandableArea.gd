extends VBoxContainer

@export var expanded_height: float = 200.0   # Açıkken içerik alanının yüksekliği
@export var collapsed_height: float = 0.0      # Kapalıyken içerik alanının yüksekliği (genellikle 0)
@export var animation_time: float = 0.3        # Animasyon süresi (saniye)

@onready var header_button: Button = $Button
@onready var content_container: Control = $PanelContainer

var is_expanded: bool = false

func _ready() -> void:
	# Başlangıçta içerik alanını kapalı konuma getir
	content_container.size.y = collapsed_height
	header_button.connect("pressed", _on_header_pressed)

func _on_header_pressed() -> void:
	# Her tıklamada açma/kapama durumunu tersine çevir
	is_expanded = not is_expanded
	
	if is_expanded:
		content_container.size.y = expanded_height
	else:
		content_container.size.y = collapsed_height
