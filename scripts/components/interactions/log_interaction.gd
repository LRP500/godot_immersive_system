extends Interaction

@export var text: String = "Lorem Ipsum"

func interact(_interactor: Node3D) -> void:
    print(text)