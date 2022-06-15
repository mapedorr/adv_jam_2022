extends Node

signal show_book_requested

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
	LOCATIONS
}

const STATE := {
	LAIR_DISCOVERED = false # false
}

var found_pages := {
	0: true, # true
	1: false, # false
	2: false, # false
	3: true, # true
	4: true, # true
	5: true, # true
	6: false, # false
	7: false, # false
	8: false, # false
	9: true, # true
	10: true, # true
	11: false, # false
}
var read_pages := []
var last_page := -1
var packed_popochius := []

# Cave: 8BBDE6

func show_book() -> void:
	emit_signal('show_book_requested')
