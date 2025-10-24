extends Node

# Test file for Godot Enhanced Extension
var player_health: int = 100
var player_name: String = "Player"

func _ready():
    print("Godot Enhanced Extension is working!")
    print("Player: %s with %d health" % [player_name, player_health])

func take_damage(amount: int) -> void:
    player_health -= amount
    if player_health <= 0:
        die()

func die() -> void:
    print("Player died!")
    queue_free()
