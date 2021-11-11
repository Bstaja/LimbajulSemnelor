extends Control

func dimensionare_buton_replay(rez_ecran):
	$Video/Replay.margin_top = -rez_ecran/2
	$Video/Replay.margin_bottom = rez_ecran/2
	$Video/Replay.margin_left = $Video/Replay.margin_top
	$Video/Replay.margin_right = $Video/Replay.margin_bottom 

func reluare_video():
	$Video/Replay.visible = false
	$Video/VideoPlayer.play()

func afisare_buton_reluare():
	$Video/Replay.visible = true
