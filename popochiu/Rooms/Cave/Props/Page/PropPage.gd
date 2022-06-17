tool
extends PopochiuProp
# You can use E.run([]) to trigger a sequence of events.
# Use yield(E.run([]), 'completed') if you want to pause the excecution of
# the function until the sequence of events finishes.

export(Globals.PageCodes) var target := 0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	if Engine.editor_hint: return
	
	if Globals.found_pages[target] or Globals.read_pages.has(target):
		disable(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the node is clicked
func on_interact() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	yield(E.run([
		'Player(happy): A page of the book!!!',
		disable()
	]), 'completed')
	
	Globals.found_pages[target] = true
	Globals.show_book(target)


# When the node is right clicked
func on_look() -> void:
	if C.player.can_move:
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
		]), 'completed')
	
	E.run(['Player: Is a page of the book!'])


# When the node is clicked and there is an inventory item selected
func on_item_used(_item: PopochiuInventoryItem) -> void:
	C.player_say('What?', false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func appear() -> void:
	if not Globals.found_pages[target] and not Globals.read_pages.has(target):
		enable(false)
