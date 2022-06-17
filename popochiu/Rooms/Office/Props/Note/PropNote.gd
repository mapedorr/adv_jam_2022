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
	]), 'completed')
	
	if Globals.office != Globals.MAIN_OFFICE:
		E.run([G.display('Mr. Popsy\nThe new freezer model is in the C.C. Salitre Plaza office.\n\nPlease give it a look and let us know if you approves its massive production.\n--The freezer makers.')])
	else:
		E.run([G.display('Mr. Popsy\nPlease take a look on the new freezer model.\n\nLet us know if you approves its massive production.\n--The freezer makers.')])


# When the node is right clicked
func on_look() -> void:
	if not C.player.can_move:
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: A note for %s.' %\
		('me' if C.player.script_name == 'Popsy' else 'Popsy')
	]), 'completed')


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	E.run(['Player: That will not work.'])
