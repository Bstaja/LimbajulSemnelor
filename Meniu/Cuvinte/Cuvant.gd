extends Control

func _ready():
	redimensionare_fereastra()
	get_tree().get_root().connect("size_changed", self, "redimensionare_fereastra")

func redimensionare_fereastra():
	var rez_ecran = OS.window_size
	var player_video = $Video/VideoPlayer
	if (player_video!=null):
		var rez_video = player_video.get_video_texture().get_size()
		var ratio = rez_video.y/rez_video.x
		var max_y = $Video.rect_size.y
		player_video.rect_size.y = $Video.rect_size.x*ratio
		if (player_video.rect_size.y>max_y):
			player_video.rect_size.y = max_y
		player_video.rect_size.x = player_video.rect_size.y/ratio
		player_video.rect_position = ($Video.rect_size-player_video.rect_size)/2
		
#		player_video.margin_top = -rez_ecran.x*ratio/2
#		if (player_video.margin_top<min_y):
#			player_video.margin_top = min_y
#		player_video.margin_bottom = player_video.margin_top*(-1)
#		player_video.rect_size.x = player_video.rect_size.y/ratio
#		player_video.margin_right = player_video.rect_size.x/2
#		player_video.margin_left = -player_video.rect_size.x/2
	dimensionare_buton_replay((rez_ecran.x+rez_ecran.y)/28)

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
