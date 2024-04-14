extends Resource
class_name LogChannel

signal message_added(message: LogMessage)

var history: Array[LogMessage]

func write(message: String) -> void:
	history.append(message)