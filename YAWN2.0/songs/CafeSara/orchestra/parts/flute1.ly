\version "2.24.2"

fluteI = \new Staff = "fluteI" \with {
  instrumentName = "flute I"
  shortInstrumentName = "fl.I"
  midiInstrument =  "flute"
} \relative c' {

  \time 3/4
  R2.
  \time 4/4
  R1
  \time 4/4
  R1
  \time 9/8
  R4. * 3

  \bar "|."

}