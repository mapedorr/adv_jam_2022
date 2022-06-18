tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const MY_PAGE := Globals.PageCodes.GONORREIN_PM
const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')

var is_playing := false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	if not can_move and Globals.playable_popochius.has(script_name):
		can_move = true


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
		if not Globals.playable_popochius.has(script_name):
			yield(E.run([C.walk_to_clicked()]), 'completed')
		
		yield(E.run([
			'Gonorrein: ' + Utils.say_in_popochiu('oñiiiiii!', 'hi!')
		]), 'completed')
		
		if not can_move:
			D.show_dialog('IntroGonorrein')
			
			yield(D, 'dialog_finished')
			
			is_playing = false
			position = room.get_point('ArcadeJump')
			
			E.run(['Gonorrein: Lets go find CHIQUININÍN!'])
			return
	else:
		E.run(['Gonorrein(back): Grrrr grrrrr grrr grrrrrr!'])
		return
	
	var choice: PopochiuDialogOption = yield(
		D.show_inline_dialog([
			'I want to control you.',
			'Nothing.'
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
	# Replace the call to .on_look() to implement your code. This only makes
	# the default behavior to happen.
	.on_look()


# When the node is clicked and there is an inventory item selected
func on_item_used(item: PopochiuInventoryItem) -> void:
	if item.script_name == 'Backpack' and C.player != self:
		if Globals.playable_popochius.has(script_name):
			Globals.packed_popochius.append(self.script_name)
			self.room.remove_character(self)
		else:
			E.run(['Gonorrein(back): Grrrr grrrr grrrr!'])


# Use it to play the idle animation for the character
func play_idle() -> void:
	$Sprite.flip_h = false
	
	if _looking_dir == 'l':
		$Sprite.flip_h = true
	
	if not is_playing:
		$AnimationPlayer.play('idle')
	else:
		$AnimationPlayer.play('back')


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
	elif emotion == 'back':
		$AnimationPlayer.play('back')
	elif emotion == 'knife':
		$AnimationPlayer.play('knife')
	else:
		$AnimationPlayer.play('talk')


# Use it to play the grab animation for the character
func play_grab() -> void:
	pass


func play_kill() -> void:
	yield()
	
	$AnimationPlayer.play('kill')
	
	yield($AnimationPlayer, 'animation_finished')
