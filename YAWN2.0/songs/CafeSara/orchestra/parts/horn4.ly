\version "2.24.2"

hornIV = \new Staff = "hornIV" \with {
  instrumentName = "horn IV"
  shortInstrumentName = "hn.IV"
  midiInstrument =  "French horn"
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