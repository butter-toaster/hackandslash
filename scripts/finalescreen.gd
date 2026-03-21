extends CanvasLayer


func _introsequence() -> void:
	GameManager.haswon = true
	GameManager.justwon = true
	
	if %LEVELHANDLER.noloserkills == true:
		GameManager.hadnoloserkills = true
	if %LEVELHANDLER.nolevelscore == true:
		GameManager.hadnolevelscore = true
	if GameManager.expertmode == true:
		GameManager.coinamount += 75
	else:
		GameManager.coinamount += 50
		
	%Player.deathmovementlock = true
	get_tree().call_group("guielements", "hide")
	var tween = create_tween()
	tween.tween_property(%finalescreen, "offset:y", 0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	%finalefade.get_parent().show()
	var fade = create_tween()
	fade.tween_property(%finalefade, "modulate", Color("244e64"), 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	%finalesfx.play()
	var record = %INTERNALCLOCK.timeelapsed
	
	if $"..".has_node("ExpertMode"):
		$time.text = "Expert Mode - Completed in " + str(record) + "s"
	else:
		$time.text = "Normal Mode - Completed in " + str(record) + "s"
	
	await get_tree().create_timer(2.5).timeout
	%score1sfx.play()
	$lscore.text = "Level Score: " + str(%Label.text)
	
	await get_tree().create_timer(0.8).timeout
	%score2sfx.play()
	var scorebonus = 40000 - (record * 100)
	if scorebonus < 0:
		scorebonus = 0
	var formattedscorebonus = "%06d" % scorebonus
	$lscore2.text = "Time Bonus: " + str(formattedscorebonus)
	
	await get_tree().create_timer(0.8).timeout
	%score3sfx.play()
	var totalscore = %scorecounternode.score + scorebonus
	GameManager.newscore = totalscore
	var formatted_totalscore = "%06d" % totalscore
	$lscore3.text = "Total Score: " + str(formatted_totalscore)
	
	if totalscore > GameManager.highscore:
		GameManager.highscore = totalscore
		%highscorelabel.visible = true
	if totalscore >= 175000:
		GameManager.had180Kscore = true
	%coinbonus.show()
	
	await get_tree().create_timer(1.8).timeout
	var buttontween = create_tween()
	buttontween.tween_property(%returnbutton, "modulate", Color.WHITE, 0.2)
	await get_tree().create_timer(0.2).timeout
	%returnbutton.disabled = false
