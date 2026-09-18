# hud.gd
extends CanvasLayer

@export var ray: RayCast3D
@export var player_stamina: Stamina

@onready var prompt: Label = $CenterContainer/VBoxContainer/PromptLabel
@onready var player_bar: ProgressBar = $PlayerStamina
@onready var mom_bar: ProgressBar = $MomStamina
@onready var list_label: RichTextLabel = $ShoppingList

func _refresh_list() -> void:
	var text := "[b]Mom's list[/b]\n"
	for item_name in GameManager.items:
		if GameManager.items[item_name]:
			text += "[s][color=gray]%s[/color][/s]\n" % item_name
		else:
			text += item_name + "\n"
	list_label.text = text

func _ready() -> void:
	ray.prompt_changed.connect(_on_prompt_changed)
	player_stamina.changed.connect(_on_player_stamina_changed)
	GameManager.list_changed.connect(_refresh_list)
	_refresh_list()
	
func _on_prompt_changed(text: String, locked: bool) -> void:
	prompt.text = text
	prompt.modulate = Color(1, 0.4, 0.4) if locked else Color.WHITE

func _on_player_stamina_changed(value: float, max_value: float) -> void:
	player_bar.max_value = max_value
	player_bar.value = value

func set_mom_stamina(value: float, max_value: float) -> void:
	mom_bar.max_value = max_value
	mom_bar.value = value
