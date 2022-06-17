tool
extends PopochiuCharacter
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

const MY_PAGE := Globals.PageCodes.POPSY_TRAPUSINSIU
const PopochiuDialogOption :=\
preload('res://addons/Popochiu/Engine/Objects/Dialog/PopochiuDialogOption.gd')

var _offices_options := []


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	_offices_options = Globals.OFFICES.duplicate()
	_offices_options.append('Lets stay here')
	
	if not can_move and Globals.read_pages.has(MY_PAGE):
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
		yield(E.run([
			'Popsy: ' + Utils.say_in_popochiu('oñiiiiii!', 'hi!')
		]), 'completed')
		
		if Globals.state.FIRST_POPSY_CHAT:
			Globals.state.FIRST_POPSY_CHAT = false
			
			D.show_dialog('PopsyIntro')
			return
	else:
		E.run([
			'Popsy: Bahbah bah bahbah bahbahbah'
		])
		return
	
	var choice: PopochiuDialogOption = yield(
		D.show_inline_dialog([
			'I want to control you.',
			"Let's go to one of your offices.",
			'Never mind.'
		]), 'completed'
	)
	
	match choice.id:
		'Opt1':
			C.player = self
			E.run(["Player: I'm on it."])
			return
		'Opt3':
			G.done()
			return
	
	if E.current_room.script_name == 'Lair'\
	and not Globals.state.CHIQUINININ_FREED:
		E.run(['Popsy: We can not leave until we find Chiquininín.'])
		return
	
	var _marked := _offices_options.duplicate()
	_marked[Globals.office] += ' (CURRENT)'
	choice = yield(D.show_inline_dialog(_marked), 'completed')
	
	if choice.id == ('Opt' + str(_offices_options.size())):
		E.run(['Popsy: Ok.'])
		return
	
	Globals.office = int(choice.id) - 1
	E.goto_room('Office')


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
			C.character_say(script_name, 'bah bah bah bah!', false)
	else:
		C.character_say(script_name, 'Ouch!', false)


# Use it to play the idle animation for the character
func play_idle() -> void:
	$Sprite.flip_h = false
	
	if _looking_dir == 'r':
		$Sprite.flip_h = true


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
