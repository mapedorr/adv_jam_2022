extends Node


static func say_in_popochiu(popochi: String, translation: String) -> String:
	return '%s\n[color=yellow](%s)[/color]' %\
	[E.get_text(popochi), E.get_text(translation)]
