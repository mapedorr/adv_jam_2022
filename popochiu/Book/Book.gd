extends CanvasLayer
# warning-ignore-all:return_value_discarded

var target_color: Color = Color.black

var _available_pages := []
var _current_page := 0 setget set_current_page
var _move_time := 0.0
var _switch := true

onready var _color_burn: TextureRect = find_node('ColorBurn')
onready var _page: TextureRect = find_node('Page')
onready var _left: TextureButton = find_node('Left')
onready var _right: TextureButton = find_node('Right')
# Defaults
onready var _page_target_pos: Vector2 = _page.rect_position
onready var _dflt_left: Vector2 = _left.rect_position
onready var _dflt_right: Vector2 = _right.rect_position


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	$Control.connect('gui_input', self, '_check_close')
	$Control.connect('mouse_entered', Cursor, 'set_cursor', [Cursor.Type.USE])
	$Control.connect('mouse_exited', Cursor, 'set_cursor')
	_left.connect('pressed', self, '_prev_page')
	_left.connect('mouse_entered', Cursor, 'set_cursor', [Cursor.Type.USE])
	_right.connect('pressed', self, '_next_page')
	_right.connect('mouse_entered', Cursor, 'set_cursor', [Cursor.Type.USE])
	
	Globals.connect('book_requested', self, 'appear')
	
	$Control.hide()
	set_process(false)


func _process(delta: float) -> void:
	_move_time += delta
	
	if _move_time >= 0.5:
		_move_time = 0.0
		
		if not _left.disabled:
			_left.rect_position.x = _dflt_left.x - 4.0 if _switch else _dflt_left.x
		
		if not _right.disabled:
			_right.rect_position.x = _dflt_right.x + 4.0 if _switch else _dflt_right.x
		
		_switch = !_switch


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func appear(in_page: int) -> void:
	target_color = E.current_room.COLOR_BURN
	_color_burn.material.set_shader_param('color1', Color.white)
	_page.rect_position.y -= 360.0
	_left.rect_position.x = -32.0
	_right.rect_position.x = 672.0
	
	for page in Globals.found_pages:
		if Globals.found_pages[page] == true:
			_available_pages.append(page)
	
	if in_page == -1:
		self._current_page = _available_pages[0]\
		if Globals.last_page == -1 else Globals.last_page
	else:
		self._current_page = _available_pages.find(in_page)
	
	$Control.show()
	A.play('sfx_close_book', false, false)
	$Tween.interpolate_method(
		self, '_burn',
		Color.white, target_color,
		0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT
	)
	$Tween.interpolate_property(
		_page, 'rect_position:y',
		null, _page_target_pos.y,
		0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT,
		0.3
	)
	$Tween.interpolate_property(
		_left, 'rect_position:x',
		null, _dflt_left.x,
		0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT,
		0.4
	)
	$Tween.interpolate_property(
		_right, 'rect_position:x',
		null, _dflt_right.x,
		0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT,
		0.4
	)
	$Tween.start()
	
	yield($Tween, 'tween_all_completed')
	
	set_process(true)


func disappear() -> void:
	A.play('sfx_close_book', false, false)
	_available_pages.clear()
	set_process(false)
	$Control.hide()
	Cursor.set_cursor()
	Globals.book_closed()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ SET/GET ░░░░
func set_current_page(value: int) -> void:
	_current_page = value
	Globals.last_page = _current_page
	_page.texture = load('res://popochiu/Book/sprites/%s.png' % str(
		_available_pages[_current_page]).pad_zeros(2)
	)
	
	var page_code: int = _available_pages[_current_page]
	if not Globals.read_pages.has(page_code):
		Globals.read_pages.append(page_code)
	
	if $Control.visible:
		randomize()
		A.play('sfx_turn_page_' + str(randi() % 2 + 1).pad_zeros(2), false, false)
	
	_enable_buttons()
	
	if _current_page == 0:
		_left.disabled = true
		_left.self_modulate.a = 0.5
	elif _current_page == _available_pages.size() - 1:
		_right.disabled = true
		_right.self_modulate.a = 0.5


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _check_close(e: InputEvent) -> void:
	var mouse_event: = e as InputEventMouseButton
	if mouse_event and mouse_event.button_index == BUTTON_LEFT \
		and mouse_event.pressed:
			disappear()


func _burn(value: Color) -> void:
	_color_burn.material.set_shader_param('color1', value)


func _prev_page() -> void:
	self._current_page = int(max(_current_page - 1, 0))


func _next_page() -> void:
	self._current_page = int(min(_current_page + 1, _available_pages.size()))


func _enable_buttons() -> void:
	_left.disabled = false
	_left.self_modulate.a = 1.0
	_right.disabled = false
	_right.self_modulate.a = 1.0
