extends CanvasLayer

var scene_to_load

func _input(event):
	if event.is_action_pressed("Pause"):
		resume_or_pause()

func _on_ResumeButton_pressed():
	resume_or_pause()

func resume_or_pause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	$PauseMenu.visible = new_pause_state

func _on_ControlsButton_pressed():
	scene_to_load = "res://Scenes/Other/TitleScreen.tscn"
	$FadeIn.fade_in()

func _on_MenuButton_pressed():
	scene_to_load = "res://Scenes/Other/TitleScreen.tscn"
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_to_load)
