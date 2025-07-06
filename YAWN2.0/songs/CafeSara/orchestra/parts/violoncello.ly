\version "2.24.2"

\include "../format.ly"

violoncello = \new Staff = "violoncello" \with {
  instrumentName = "violoncello"
  shortInstrumentName = "vc."
  midiInstrument = "cello"
}
<<
  \relative {
    \clef bass

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
    r2 \acciaccatura { gis16\(\glissando^ \markup { \italic { "II?" } } } fis8
    \repeat unfold 2 { \acciaccatura { gis16\glissando } fis8 } \acciaccatura { gis16\glissando } f8~
    f4.\)\glissando \acciaccatura { a16\(\glissando } gis8 gis a a b
    e4\) e,,2.->\ff~
    \time 2/4
    e2\<
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