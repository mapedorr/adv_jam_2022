tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: I hope this key will lead us to Chiquininín.',
		disable(),
		I.add_item('Key'),
	]), 'completed')


# When the node is right clicked
func on_look() -> void:
	yield(E.run([
		C.face_clicked(),
		'Player: Is the key Roberto threw.',
	]), 'completed')


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	yield(E.run([
		C.face_clicked(),
		'Player: Why?',
	]), 'completed')
