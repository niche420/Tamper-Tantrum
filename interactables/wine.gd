extends Interactable

func _interact(player: Node) -> void:
	$BottleSprite.visible = false
	$BrokenSprite.visible = true
	Inventory.add("glass_shard")
	$StaticBody3D/CollisionShape3D.set_deferred("disabled", true)
