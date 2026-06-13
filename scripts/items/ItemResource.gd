# scripts/items/ItemResource.gd
class_name ItemResource
extends Resource

@export var item_name: String = "Unknown Item"
@export var icon: Texture2D
@export var category: String = "MISC"          # WATER, FOOD, MEDICAL, TOOLS, BOARDS, FUEL, GENERATOR_PART
@export var max_stack: int = 10
@export var volume: float = 1.0                # Used for shelter storage limits (later)
@export var weight: float = 1.0                # Used for carry weight limit
@export var description: String = ""
