tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const MY_PAGE := Globals.PAGE_CODES.POPSY_TRAPUSINSIU


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if Globals.read_pages.has(MY_PAGE):
		E.run([
			'Popsy: Hiiiiii!'
		])
	else:
		E.run([
			'Popsy: Bahbah bah bahbah bahbahbah'
		])


# When the node is right clicked
func on_look() -> void:
	pass


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == 'Backpack' and C.player != self:
		Globals.packed_popochius.append(self.script_name)
		self.room.remove_character(self)
#		disable(false)
	else:
		.on_item_used(item)


# Use it to play the idle animation for the character
func play_idle() -> void:
	pass


# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func play_walk(target_pos: Vector2) -> void:
	.play_walk(target_pos)


# Use it to play the talk animation for the character
func play_talk() -> void:
	pass


# Use it to play the grab animation for the character
func play_grab() -> void:
	pass
