tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

export(Globals.PAGE_CODES) var target := 0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Globals.found_pages[target]:
		disable(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player(happy): A page of the book!!!',
		disable()
	]), 'completed')
	
	Globals.found_pages[target] = true
	Globals.show_book(target)


# When the node is right clicked
func on_look() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: Is a page of the book!'
	]), 'completed')


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	C.player_say('What?', false)
