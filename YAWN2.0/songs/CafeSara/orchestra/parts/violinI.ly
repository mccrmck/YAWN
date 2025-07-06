\version "2.24.2"

\include "../format.ly"
\include "../utils.ly"

violinI = \new Staff = "violinI" \with {
  instrumentName = "violinI"
  shortInstrumentName = "vln.I"
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
    \repeat unfold 5 {
      R1 * 8
    }
    R1 * 7
    \once \override Glissando.bound-details.right.arrow = ##t
    \override Glissando.thickness = #2
    b''4:8\glissando s2 b4:16~
    \bar "||"

    % HARMONY
    b2.:16 r8 gis8~->\downbow
    gis2.. gis8~->\downbow
    gis4. a8~ a2
    b1->~\downbow

    b8 r8 gis2.->~\downbow
    gis8 r8 gis4~->\downbow gis4 a~
    a4 r8 b8~->\downbow b2~

    b2 r8 gis4.~->\downbow
    gis2 r8 gis4.~->\downbow
    gis8 a4.~ a8 r8 b4~->\downbow
    b2.. r8

    gis4->\downbow\glissando \glissandoSkipOn a a b\glissandoSkipOff
    c2-> cis2->\downbow
    r8 b4.->\downbow\glissando \glissandoSkipOn c4 d \glissandoSkipOff

    e4:16 r8 f,8~->\downbow f2~
    f4 r8 f8~->\downbow f2~
    f2 gis2~->\downbow

    gis4 a2\downbow b4~->\downbow
    b2 r4 cis4~->\downbow
    cis4 dis2\downbow r8 e8~->\downbow
    e2..\glissando gis8
    \slurUp
    r2 \acciaccatura { gis16\(\glissando^ \markup { \italic { "I?" } } } fis8
    \repeat unfold 2 { \acciaccatura { gis16\glissando } fis8 } \acciaccatura { gis16\glissando } f8~
    f4.\)\glissando \acciaccatura { a16\(\glissando } gis8 gis a a b
    b2:16\)\glissando s2
    \time 2/4
    s4 b,4:16
    %  \ottava #0
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