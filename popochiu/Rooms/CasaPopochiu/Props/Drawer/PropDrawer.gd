tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if not C.player.can_move:
		E.run([G.display('You are not controlling any character!')])
		return
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked()
	]), 'completed')
	
	$Sprite.frame = 1
	
	if I.is_item_in_inventory('Backpack'):
		yield(E.run([
			'..',
			'Player: Nothing else here...',
		]), 'completed')
	else:
		yield(E.run([
			'..',
			'Player: This is the backpack for Popochius!',
			I.add_item('Backpack')
		]), 'completed')
		
	$Sprite.frame = 0


# When the node is right clicked
func on_look() -> void:
	# Replace the call to .on_look() to implement your code. This only makes
	# the default behavior to happen.
	.on_look()


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	# Replace the call to .on_item_used(item) to implement your code. This only
	# makes the default behavior to happen.
	.on_item_used(item)
