function create() {
	var hitwindow = 62.5;
	
	for (sl in strumLines)
		sl.onNoteUpdate.add(function(event) {
			if (!event.note.isSustainNote) return;
			event.cancelWindowUpdate();

			event.note.canBeHit = (event.note.strumTime > Conductor.songPosition - (hitwindow * event.note.latePressWindow/1.5) && event.note.strumTime < Conductor.songPosition + (hitwindow * event.note.earlyPressWindow/1.5));
			if (event.note.strumTime < Conductor.songPosition - hitwindow && !event.note.wasGoodHit) event.note.tooLate = true;
		});
}