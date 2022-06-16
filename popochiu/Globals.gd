extends Node
# warning-ignore-all:unused_signal

signal book_requested(page)
signal book_closed

enum PAGE_CODES {
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
}

var state := {
	BOOK_CRYSTAL_BROKEN = false, # false
	LAIR_DISCOVERED = false, # false
	SCEPTER_IN_PLACE = false, # false
	SCEPTER_PUSHED = false, # false
	
}
var found_pages := {
	PAGE_CODES.COVER: true, # true
	PAGE_CODES.CREDITS: false, # false
	PAGE_CODES.TOC: false, # false
	PAGE_CODES.STORY: true, # true
	PAGE_CODES.GI: true, # true
	PAGE_CODES.GODDIU_CHIQUINININ: true, # true
	PAGE_CODES.POPSY_TRAPUSINSIU: false, # false
	PAGE_CODES.GONORREIN_PM: false, # false
	PAGE_CODES.OTHER_CREATURES: false, # false
	PAGE_CODES.ITEMS: true, # true
	PAGE_CODES.LOCATIONS_1: true, # true
	PAGE_CODES.LOCATIONS_2: false, # false
}
var read_pages := [
#	PAGE_CODES.GODDIU_CHIQUINININ
]
var last_page := -1
var packed_popochius := []


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func show_book(page := -1) -> void:
	emit_signal('book_requested', page)


func book_closed() -> void:
	emit_signal('book_closed')
