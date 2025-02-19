extends Panel

@onready var item_visual = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slots: InvSlot):
	if slots.item == null:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slots.item.texture
		if slots.amount >1:
			amount_text.visible = true
		amount_text.text = str(slots.amount)
