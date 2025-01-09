extends Panel

@onready var item_visual = $CenterContainer/Panel/item_display

func update(item: InvItem):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
