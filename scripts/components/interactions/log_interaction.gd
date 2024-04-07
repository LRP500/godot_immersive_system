extends Interaction

@export var text: String = "Lorem Ipsum"

func interact_start(_interactor: Interactor) -> void:
    print(text)