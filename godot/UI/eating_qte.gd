extends Control

signal in_the_green
signal exit_green
signal time_up

func green() -> void:
	in_the_green.emit()

func red() -> void:
	exit_green.emit()

func finish() -> void:
	time_up.emit()
