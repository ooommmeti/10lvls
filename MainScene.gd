extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_level

var level_files=["level0","level1","level2","level3","level4","level5","level6","level7","level8","level9","level10"]

# Called when the node enters the scene tree for the first time.
func _ready():
	start_level(Globals.current_level_id);
	pass # Replace with function body.

func start_level(level_id):
	#var level = load("res://levels/level0.tscn").instance();
	var level = load("res://levels/"+level_files[level_id]+".tscn").instantiate();
	get_tree().current_scene.add_child(level);
	current_level = level
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body is Block:
		match (body as Block).type_id:
			1:
				print("Red")
				#скільки всього червоних на екрані?
				var num_red = 0;
				for b in current_level.get_children():
					if b is Block:
						if (b as Block).type_id==1:
							num_red+=1;
				print("num_red=",num_red)
				if num_red==1:
					print("Victory")
					$VictoryTimer.start()
				
				
			2:
				print("Green")
				print("GAME OVER")
				$VictoryTimer.stop()
				get_tree().change_scene_to_file("res://DefeatScreen.tscn")
				
		
					
		body.queue_free()
	pass # Replace with function body.


func _on_Button_pressed():
	current_level.queue_free();
	start_level(Globals.current_level_id);
	pass # Replace with function body.


func _on_victory_timer_timeout():
	print("tick")
	get_tree().change_scene_to_file("res://VictoryScreen.tscn")
	pass # Replace with function body.
