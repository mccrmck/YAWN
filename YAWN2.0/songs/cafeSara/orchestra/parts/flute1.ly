\version "2.24.2"

\include "../format.ly"

fluteI = \new Staff = "fluteI" \with {
  instrumentName = "flute I"
  shortInstrumentName = "fl.I"
  midiInstrument =  "flute"
}
<<
  \relative c' {

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
    r2 \acciaccatura { gis''16\( } fis8
    \repeat unfold 2 { \acciaccatura { gis16 } fis8 } \acciaccatura { gis16 } f8~
    f4.\) \acciaccatura { a16\( } gis8 gis a a b
    \once \override Glissando.bound-details.right.arrow = ##t
    \override Glissando.thickness = #2
    b2\)\glissando s2
    \time 2/4
    b2:16^ \markup { \italic { "flz." } }
    \bar "||"
    % PANTERA
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