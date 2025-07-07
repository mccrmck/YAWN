\version "2.24.2"

\include "../format.ly"
\include "../dynamics.ly"

hornIV = \new Staff = "hornIV" \with {
  instrumentName = "horn IV"
  shortInstrumentName = "hn.IV"
  midiInstrument =  "French horn"
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
    \repeat unfold 6 { R1 * 8 }
    \bar "||"

    % HARMONY
    <<
      {
        \time 4/4
        r2.. cis8~->
        cis2. r8 f~->
        f2.. r8
        e1->~

        e8 r8 cis2.->
        r4 f2.~->
        f4 r8 e8~-> e2~

        e2 r8 cis4.~->
        cis2 r8 f4.~->
        f2. e4~->
        e1

        cis1->
        f1->
        r8 e4.~-> e2~

        e4 r8 cis8~-> cis2~
        cis4 r8 f8~-> f2~
        f2 e2~->

        e2. cis4~->
        cis2. f4~->
        f2. r8 e8~->

        e1
        r8 cis4.~-> cis2
        r8 f4.~-> f2
        r4 e2.->~

        \time 2/4
        e2
      }
      \harmonyTempi
      \harmonyPadDynamics
    >>
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