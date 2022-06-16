tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Globals.state.BOOK_CRYSTAL_BROKEN:
		description = 'book'
		$Crystal.hide()
	if I.is_item_in_inventory('Book'):
		disable(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if Globals.state.BOOK_CRYSTAL_BROKEN:
		yield(E.run([
			I.add_item('Book'),
			disable(),
			'..',
		]), 'completed')
		
		Globals.show_book()
	else:
		E.run([G.display('????')])


# When the node is right clicked
func on_look() -> void:
	# Replace the call to .on_look() to implement your code. This only makes
	# the default behavior to happen.
	.on_look()


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == 'LilChipper' and not Globals.state.BOOK_CRYSTAL_BROKEN:
		Globals.state.BOOK_CRYSTAL_BROKEN = true
		description = 'Book'
		# TODO: Play animation and sfx
		I.remove_item('LilChipper', false)
		$Crystal.hide()
	else:
		.on_item_used(item)
