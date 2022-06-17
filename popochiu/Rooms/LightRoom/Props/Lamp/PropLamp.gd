tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	E.run(['Player: Everything is fine where it is.'])


# When the node is right clicked
func on_look() -> void:
	E.run(['Player: The lamp with the bulb that lights up this room.'])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name != 'Bulb':
		E.run(['Player: Better not.'])
		return
	
	if not C.player.can_move:
		return
	
	Globals.state.LIGHT_ROOM_COLOR = Globals.PINK_LIGHT
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Player: Lets change the color of this room!',
	]), 'completed')
	
	if Globals.state.LIGHT_ROOM_ON:
		E.run([
			E.runnable(room, 'toggle_light', [false]),
			I.remove_item('Bulb'),
			'...',
			E.runnable(room, 'toggle_light', [true]),
		])
	else:
		E.run([
			I.remove_item('Bulb'),
			E.runnable(room, 'toggle_light', [true]),
		])
