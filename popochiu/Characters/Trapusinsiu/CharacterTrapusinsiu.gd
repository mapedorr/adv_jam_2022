tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const MY_PAGE := Globals.PageCodes.POPSY_TRAPUSINSIU
const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _exit_tree() -> void:
	if Engine.editor_hint: return
	
	if C.player.script_name != script_name\
	and Globals.playable_popochius.has(script_name)\
	and not Globals.packed_popochius.has(script_name):
		Globals.packed_popochius.append(script_name)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if Globals.in_roberto_dialog: return
	
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
			'Trapusinsiu: Hmhmhm hm hmhmhmhmm hmm'
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
		if Globals.playable_popochius.has(script_name):
			Globals.packed_popochius.append(self.script_name)
			self.room.remove_character(self)
		else:
			C.character_say(script_name, 'Hmmm hmmhmmm hmmm hm!', false)
	else:
		C.character_say(script_name, 'Ouch!', false)


# Use it to play the idle animation for the character
func play_idle() -> void:
	$Sprite.flip_h = false
	
	if _looking_dir == 'l':
		$Sprite.flip_h = true
	
	$AnimationPlayer.play('idle')


# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func play_walk(target_pos: Vector2) -> void:
	$AnimationPlayer.play('walk')


# Use it to play the talk animation for the character
func play_talk() -> void:
	$Sprite.flip_h = false
	
	if _looking_dir == 'l':
		$Sprite.flip_h = true
	
	if emotion == 'sad':
		$AnimationPlayer.play('cry')
	elif emotion == 'happy':
		$AnimationPlayer.play('happy')
	else:
		$AnimationPlayer.play('talk')


# Use it to play the grab animation for the character
func play_grab() -> void:
	pass
