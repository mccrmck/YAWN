\version "2.24.2"


glissandoSkipOn = {
  \override NoteColumn.glissando-skip = ##t
  \hide NoteHead
  \hide Accidental
  \override NoteHead.no-ledgers = ##t
}

glissandoSkipOff = {
  \override NoteColumn.glissando-skip = ##f
  \undo \hide NoteHead
  \undo \hide Accidental
  \override NoteHead.no-ledgers = ##f
}
