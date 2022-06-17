tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	disable(false)
	
	
	if not I.is_item_in_inventory('Translator') and\
	(Globals.office == Globals.TRANSLATOR_OFFICE and\
	Globals.state.PUSHED_DESKS.has(Globals.TRANSLATOR_OFFICE)
	):
		enable(false)

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: So there was the translator.',
		disable(),
		I.add_item('Translator'),
		'Player: How did you know?'
	]), 'completed')


# When the node is right clicked
func on_look() -> void:
	yield(E.run([
		C.face_clicked(),
		'Player: Is the translator we used to talk with Marcianiu!!!!',
	]), 'completed')


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	yield(E.run([
		C.face_clicked(),
		"Player: I don't wanna",
	]), 'completed')
