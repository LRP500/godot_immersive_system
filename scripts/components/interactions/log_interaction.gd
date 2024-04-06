extends Interaction

@export var text: String = "Lorem Ipsum"

func start_interact(_interactor: Interactor) -> void:
    print(text)