\version "2.24.2"

\include "../format.ly"

percI = \new Staff = "percI" \with {
  instrumentName = "perc I"
  shortInstrumentName = "prc.I"
  midiInstrument =  "orchestra drums"
}
<<
  \relative {
    \clef percussion
    % LASTB
    R1 * 3
    \time 2/4
    R2
    \bar "||"

    % DOOM

    \time 3/4
    g2.--
    \time 4/4
    g1-- g--
    \compoundMeter #'((2 2 3 2 8))
    g2~-- g4. g4--

    \time 3/4
    g2.--
    \time 4/4
    g1-- g--
    \compoundMeter #'((2 2 2 3 8))
    g2.-> g4.->

    \time 3/4
    g2.--
    \time 4/4
    g1-- g--
    \compoundMeter #'((2 2 3 2 8))
    g2~-- g4. g4~--

    % AMBIENCE
    \time 4/4
    \tempo 4 = 60
    \override Glissando.thickness = #6
    g1:16\glissando\pp^ \markup { \box { "gran cassa" } }
    s1 * 6
    << { \single \hideNotes g4 } R1 >>
    R1 * 40
    \bar "||"


    \clef treble
    r2.^ \markup { \box { "tubular bells" } } r8  << cis-> gis'\laissezVibrer >>
    r2.. << f8-> c'\laissezVibrer >>
    R1
    << e,4-> b'\laissezVibrer >> r2.
    r4 << cis,4-> gis'\laissezVibrer >> r2
    r4 << f4-> c'\laissezVibrer >> r2
    r4. << e,8-> b'\laissezVibrer >> r2
    r2 r8 << cis,4.-> gis'\laissezVibrer >>
    r2 r8 << f4.-> c'\laissezVibrer >>
    r2. << e,4-> b'\laissezVibrer >>
    R1

    \clef percussion
    g,4.->-.\f\>^ \markup { \box { "gran cassa" } } r8\! r2
    \clef treble
    << f'4-> c'\laissezVibrer^ \markup { \box { "tubular bells" } } >> r2.
    \clef percussion
    r8 g,4->-.\mf\>^ \markup { \box { "gran cassa" } } r8\! r2
    \clef treble
    r4. << cis8-> gis'\laissezVibrer >> r2
    r4. << f8-> c'\laissezVibrer >> r2
    r2 << e,4-> b'\laissezVibrer >>  r4                   %  zipper!!
    r2. << cis,4-> gis'\laissezVibrer >>
    r2. << f4-> c'\laissezVibrer >>
    r2.. << e,8-> b'\laissezVibrer >>
    R1
    r8 << cis4.-> gis'\laissezVibrer >> r2
    r8 << f4.-> c'\laissezVibrer >> r2
    r4 << e,4-> b'\laissezVibrer >> r2
    \time 2/4
    R2
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