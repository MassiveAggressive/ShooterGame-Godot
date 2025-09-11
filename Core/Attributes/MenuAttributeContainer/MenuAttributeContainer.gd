class_name MenuAttributeContainer extends AttributeContainerBase

func _ready() -> void:
	SceneManager.SceneAboutToChange.connect(OnSceneAboutToChange)
