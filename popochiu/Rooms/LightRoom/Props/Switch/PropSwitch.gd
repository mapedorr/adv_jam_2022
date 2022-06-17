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
	
	yield(E.run([
		'Player: Gonna turn it %s.' % ('on' if $Sprite.frame == 0 else 'off')
	]), 'completed')
	
	room.toggle_light($Sprite.frame == 0)


# When the node is right clicked
func on_look() -> void:
	E.run(['Player: Is the switch for the light...'])


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	E.run(['Player: Why.....?'])
