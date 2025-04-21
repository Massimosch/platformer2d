extends Node

var playerBody: BaseCharacter
var have_attacked = false
var player_alive = true
var game_started : bool
var can_move : bool = true
var current_wave : int
var moving_to_next_wave : bool

var high_score = 0
var current_score : int
var previous_score: int
