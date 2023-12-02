\version "2.24.2"

\include "../format.ly"


violinII = \new Staff = "violoncello" \with {
  instrumentName = "violinII"
  shortInstrumentName = "vln.II"
  midiInstrument = "violin"
}
<<
  \relative {

    % LASTB
    \time 4/4
    R1 * 3
    \time 2/4
    R2
    \bar "||"

    % DOOM
    \time 3/4
    R2.
    \time 4/4
    R1 * 2
    \compoundMeter #'((2 2 3 2 8))
    R1 * 9/8

    \time 3/4
    R2.
    \time 4/4
    R1 * 2
    \compoundMeter #'((2 2 2 3 8))
    R1 * 9/8

    \time 3/4
    R2.
    \time 4/4
    R1 * 2
    \compoundMeter #'((2 2 3 2 8))
    R1 * 9/8

    % AMBIENCE
    \time 4/4
    \repeat unfold 6 {
      R1 * 8
    }
    \bar "||"

    % HARMONY
    R1 * 6
    R1 * 6
    R1 * 6
    R1 * 3
    \slurUp
    r2 \acciaccatura { gis''16\(\glissando^ \markup { \italic { "II?" } } } fis8
    \repeat unfold 2 { \acciaccatura { gis16\glissando } fis8 } \acciaccatura { gis16\glissando } f8~
    f4.\)\glissando \acciaccatura { a16\(\glissando } gis8 gis a a b
    e2:16\)\glissando s2
    \time 2/4
    s4 e,4:16
    \bar "||"

    \time 4/4
    <<
      {
        R1 * 8
      }
      \panteraTempi
    >>

    \bar "|."
  }
  \scoreFormat
>>