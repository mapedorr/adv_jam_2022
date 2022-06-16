tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const MY_PAGE := Globals.PAGE_CODES.POPSY_TRAPUSINSIU
const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _exit_tree() -> void:
	if Engine.editor_hint: return
	
	if C.player.script_name != script_name:
		Globals.packed_popochius.append(script_name)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if Globals.read_pages.has(MY_PAGE):
		yield(E.run([
			'Trapusinsiu: ' + Utils.say_in_popochiu('oñiiiiii!', 'hi!')
		]), 'completed')
		
		if Globals.state.FIRST_TRAPUSINSIU_CHAT:
			Globals.state.FIRST_TRAPUSINSIU_CHAT = false
			
			D.show_dialog('TrapusinsiuIntro')
			return
	else:
		E.run([
			'Trapusinsiu: Prrrr prr prrrrrrrrrrrr'
		])
		return
	
	var choice: PopochiuDialogOption = yield(
		D.show_inline_dialog([
			'I want to control you.',
			'Keep... staying still'
		]), 'completed'
	)
	
	match choice.id:
		'Opt1':
			C.player = self
			E.run(["Player: I'm on it."])
		_:
			G.done()


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
