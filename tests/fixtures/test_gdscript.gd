## Test GDScript file for validation
## This file tests all major GDScript syntax features

class_name TestScript extends Node2D

# Enums
enum GameMode {
	SINGLE_PLAYER,
	MULTIPLAYER,
	COOP
}

# Constants
const MAX_HEALTH: int = 100
const SPEED: float = 300.0

# Signals
signal health_changed(new_health: int)
signal player_died

# Export variables
@export var player_name: String = "Player"
@export_range(0, 100) var health: int = 100
@export var speed: float = SPEED

# Private variables
var _current_wave: int = 0
var _is_game_running: bool = false

# Ready function
func _ready() -> void:
	print("TestScript ready")
	_initialize_game()

# Process function
func _process(delta: float) -> void:
	if _is_game_running:
		_update_game(delta)

# Physics process
func _physics_process(delta: float) -> void:
	var velocity := Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	velocity = velocity.normalized() * speed

# Private method
func _initialize_game() -> void:
	health = MAX_HEALTH
	_is_game_running = true
	health_changed.emit(health)

# Public method with parameters
func take_damage(amount: int) -> void:
	health = max(0, health - amount)
	health_changed.emit(health)
	
	if health <= 0:
		die()

# Method with return type
func get_health_percentage() -> float:
	return float(health) / float(MAX_HEALTH)

# Method with match statement
func handle_game_mode(mode: GameMode) -> void:
	match mode:
		GameMode.SINGLE_PLAYER:
			print("Starting single player")
		GameMode.MULTIPLAYER:
			print("Starting multiplayer")
		GameMode.COOP:
			print("Starting coop")
		_:
			print("Unknown mode")

# Async function
func load_level(level_name: String) -> void:
	print("Loading level: ", level_name)
	await get_tree().create_timer(2.0).timeout
	print("Level loaded!")

# Method with dictionary
func get_player_stats() -> Dictionary:
	return {
		"name": player_name,
		"health": health,
		"speed": speed,
		"level": _current_wave
	}

# Array manipulation
func process_enemies(enemies: Array) -> Array:
	var alive_enemies := []
	for enemy in enemies:
		if enemy.has_method("is_alive") and enemy.is_alive():
			alive_enemies.append(enemy)
	return alive_enemies

# Lambda function
func apply_to_all(items: Array, callback: Callable) -> void:
	for item in items:
		callback.call(item)

# Static method
static func calculate_damage(base_damage: int, multiplier: float) -> int:
	return int(base_damage * multiplier)

# Virtual method
func die() -> void:
	player_died.emit()
	queue_free()

# Inner class
class Inventory:
	var items: Array = []
	
	func add_item(item: Variant) -> void:
		items.append(item)
	
	func get_item_count() -> int:
		return items.size()
