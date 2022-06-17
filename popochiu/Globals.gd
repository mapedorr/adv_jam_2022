extends Node
# warning-ignore-all:unused_signal

signal book_requested(page)
signal book_closed

enum PageCodes {
	COVER,
	CREDITS,
	TOC,
	STORY,
	GI,
	GODDIU_CHIQUINININ,
	POPSY_TRAPUSINSIU,
	GONORREIN_PM,
	OTHER_CREATURES,
	ITEMS,
	LOCATIONS_1,
	LOCATIONS_2,
	LOCATIONS_3,
}

const BLUE_LIGHT := '00f3ff'
const PINK_LIGHT := 'eaaded'
const OFFICES := [
	'C.C. Av. Chile',
	'Cl. 53b 25 21',
	'Ak. 68 66c 90',
	'Cl. 118 19a 59',
	'Cl. 26 62 49 Isla 1-06',
	'C.C. Salitre Plaza',
	'Cl. 80 59 79',
]
const TRANSLATOR_OFFICE := 2
const MAIN_OFFICE := 5

var state := {
	BOOK_CRYSTAL_BROKEN = false, # false
	SCEPTER_IN_PLACE = false, # false
	SCEPTER_PUSHED = false, # false
	SYMBOL_ACTIVATED = false, # false
	FIRST_TRAPUSINSIU_CHAT = true, # true
	LIGHT_ROOM_ON = false, # false
	LIGHT_ROOM_COLOR = BLUE_LIGHT, # BLUE_LIGHT
	PUSHED_DESKS = [],
	ROBERTO_KILLED = false, # false
	LAIR_DISCOVERED = false, # false
	PUSHED_SAFEBOX = false, # false
	CHIQUINININ_FREED = false, # false
}
var found_pages := {
	PageCodes.COVER: true, # true
	PageCodes.CREDITS: false, # false
	PageCodes.TOC: true, # true (aún no estoy seguro...)
	PageCodes.STORY: true, # true
	PageCodes.GI: true, # true
	PageCodes.GODDIU_CHIQUINININ: true, # true
	PageCodes.POPSY_TRAPUSINSIU: false, # false
	PageCodes.GONORREIN_PM: false, # false
	PageCodes.OTHER_CREATURES: false, # false
	PageCodes.ITEMS: true, # true
	PageCodes.LOCATIONS_1: true, # true
	PageCodes.LOCATIONS_2: true, # false
	PageCodes.LOCATIONS_3: false, # false
}
var read_pages := [
#	PageCodes.GODDIU_CHIQUINININ,
#	PageCodes.POPSY_TRAPUSINSIU,
#	PageCodes.GONORREIN_PM,
]
var last_page := -1
var packed_popochius := [
#	'Goddiu',
#	'Popsy',
#	'Trapusinsiu',
#	'Gonorrein',
]
var playable_popochius := [
#	'Goddiu',
#	'Popsy',
#	'Trapusinsiu',
#	'Gonorrein',
#	'Chiquininin'
]
var office := 0
var in_roberto_dialog := false # false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func show_book(page := -1) -> void:
	emit_signal('book_requested', page)


func book_closed() -> void:
	emit_signal('book_closed')
