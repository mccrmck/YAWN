\version "2.24.2"

fluteII = \new Staff = "fluteII" \with {
  instrumentName = "flute II"
  shortInstrumentName = "fl.II"
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