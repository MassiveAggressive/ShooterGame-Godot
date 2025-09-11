class_name MenuAttributeContainer extends AttributeManagerBase

func _ready() -> void:
	SceneManager.SceneAboutToChange.connect(OnSceneAboutToChange)
