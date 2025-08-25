extends VBoxContainer

@export var title: String = "Section"
@export var collapsed_by_default: bool = true
@export var duration: float = 0.25
@export var ease_trans: int = Tween.TRANS_CUBIC
@export var ease_type: int = Tween.EASE_IN_OUT

@onready var header_button: Button = $HeaderButton as Button
@onready var body_wrapper: Control = $BodyWrapper as Control
@onready var body: Control = $BodyWrapper/Body as Control

var expanded: bool = false
var _tween: Tween = null
var _expanded_height: float = 0.0

func _ready() -> void:
	# Başlık
	header_button.text = title
	header_button.pressed.connect(_on_header_pressed)

	# İçeriği kırp (BodyWrapper Inspector: clip_contents = true da açabilirsin)
	if body_wrapper.has_method("set_clip_contents"):
		body_wrapper.clip_contents = true

	# Minimum boyutlar hesaplansın diye bir kare bekle
	await get_tree().process_frame
	_expanded_height = _get_body_target_height()

	if collapsed_by_default:
		expanded = false
		body_wrapper.visible = false
		body_wrapper.modulate.a = 0.0
		body_wrapper.custom_minimum_size = Vector2(body_wrapper.custom_minimum_size.x, 0.0)
	else:
		expanded = true
		body_wrapper.visible = true
		body_wrapper.modulate.a = 1.0
		body_wrapper.custom_minimum_size = Vector2(body_wrapper.custom_minimum_size.x, _expanded_height)

func _on_header_pressed() -> void:
	if expanded:
		_collapse()
	else:
		_expand()

func _expand() -> void:
	expanded = true
	if _tween != null:
		_tween.kill()

	# İçerik yüksekliğini yeniden hesapla (dinamik içerik için)
	_expanded_height = _get_body_target_height()

	body_wrapper.visible = true

	_tween = create_tween()
	_tween.set_trans(ease_trans)
	_tween.set_ease(ease_type)
	_tween.tween_property(body_wrapper, "custom_minimum_size:y", _expanded_height, duration)
	_tween.parallel().tween_property(body_wrapper, "modulate:a", 1.0, duration)

func _collapse() -> void:
	expanded = false
	if _tween != null:
		_tween.kill()

	_tween = create_tween()
	_tween.set_trans(ease_trans)
	_tween.set_ease(ease_type)
	_tween.tween_property(body_wrapper, "custom_minimum_size:y", 0.0, duration)
	_tween.parallel().tween_property(body_wrapper, "modulate:a", 0.0, duration)
	await _tween.finished
	# Hâlâ kapalıysa görünürlüğü kapat (animasyon biter bitmez)
	if not expanded:
		body_wrapper.visible = false

func _get_body_target_height() -> float:
	# İçeriğin toplam minimum yüksekliği; margin/padding dahil
	var ms: Vector2 = body.get_combined_minimum_size()
	return ms.y
