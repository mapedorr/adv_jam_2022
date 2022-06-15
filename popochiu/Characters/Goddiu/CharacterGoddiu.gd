tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const MY_PAGE := Globals.PAGE_CODES.GODDIU_CHIQUINININ


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if Globals.read_pages.has(MY_PAGE):
		E.run([
			'Goddiu: Hiiiiii!'
		])
	else:
		E.run([
			'Goddiu: Dabudabu baba dabu babudabu'
		])


# When the node is right clicked
func on_look() -> void:
	C.player = self


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
	$AnimationPlayer.play('RESET')


# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func play_walk(target_pos: Vector2) -> void:
	$AnimationPlayer.play('walk')


# Use it to play the talk animation for the character
func play_talk() -> void:
	pass


# Use it to play the grab animation for the character
func play_grab() -> void:
	pass
