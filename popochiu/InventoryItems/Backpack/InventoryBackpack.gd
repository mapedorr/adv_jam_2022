extends PopochiuInventoryItem

const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods as needed


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the item is clicked in the inventory
func on_interact() -> void:
	# Replace the call to .on_interact() to implement your code. This only makes
	# the default behavior to happen.
	.on_interact()


# When the item is right clicked in the inventory
func on_look() -> void:
	if Globals.packed_popochius.empty(): return
	
	yield(E.run(['Player: Which popochiu should go out?']), 'completed')
	var options := Globals.packed_popochius.duplicate()
	options.append('None')
	var choice: PopochiuDialogOption = yield(
		D.show_inline_dialog(options), 'completed'
	)
	if choice.text != 'None':
		Globals.packed_popochius.erase(choice.text)
		E.current_room.add_character(C.get_character(choice.text))
		G.done()
	else:
		E.run(['Player: Ok by me!'])


# When the item is clicked and there is another inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	# Replace the call to .on_item_used(item) to implement your code. This only
	# makes the default behavior to happen.
	.on_item_used(item)


# Actions to excecute after the item is added to the Inventory
func added_to_inventory() -> void:
	# Replace the call to .added_to_inventory() to implement your code. This only
	# makes the default behavior to happen.
	.added_to_inventory()
