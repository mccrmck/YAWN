\version "2.24.2"

\include "../scaledBars.ly"
\include "../format.ly"
\include "../utils.ly"

red = \once \override NoteHead.color = #red

tuba = \new Staff = "tuba" \with {
  instrumentName = "tuba"
  shortInstrumentName = "tuba"
  midiInstrument = "tuba"
  \consists "Horizontal_bracket_engraver"
}
<<
  \relative {
    \clef bass

    % LASTB
    R1 * 3
    \time 2/4
    R2
    \bar "||"

    % DOOM
    \time 3/4
    b,2.\(->\mf\<
    \time 4/4
    b1-> dis1->
    \compoundMeter #'((2 2 3 2 8))
    c2~-> c4. b4->\)

    \time 3/4
    dis2.->\f\<\(
    \time 4/4
    c1-> b1->
    \compoundMeter #'((2 2 2 3 8))
    b2.-> dis4.->\)

    \time 3/4
    c2.->\ff\<\(
    \time 4/4
    b1-> b1->
    \compoundMeter #'((2 2 3 2 8))
    dis2~-> dis4. c4~->\fff\>

    % AMBIENCE
    \time 4/4
    \tempo 4 = 60
    \override Glissando.thickness = #6
    \override Glissando.to-barline = ##t
    c1~ c1\)\!  R1 * 5

    \override Hairpin.circled-tip = ##t
    \override Hairpin.to-barline = ##t
    <<
      {
        \once \override Glissando.bound-details.right.Y = #-0.5
        cis1\glissando s1 * 5

        r2 f2\glissando s1 * 5
        s2 r2
        r4 e2.\glissando s1 * 5 s2. r4

        r2 cis2\glissando s1 * 4 s4 r2.
        f1\glissando s1 * 3 s4 r2.
        e1\glissando s1 * 3
        r2. cis4\glissando s1 * 2 s2. r4
        
        r4. f8\glissando s2 s1 s4 r8 r2.
        R1 * 4
        
      }{
        s1 * 3 \glissandoSkipOn cis4 cis cis cis \glissandoSkipOff s1 \glissandoSkipOn cis4 cis cis cis \glissandoSkipOff \single \hideNotes cis2
        s2 s1 * 2 \glissandoSkipOn f4 f f f \glissandoSkipOff s1 * 2 \glissandoSkipOn f4 f4 \glissandoSkipOff \single \hideNotes f2
        s1 * 3 \glissandoSkipOn e4 e e e \glissandoSkipOff s1 * 2 \glissandoSkipOn e4 e e \glissandoSkipOff \single \hideNotes e
        s1 * 3 \glissandoSkipOn cis4 cis cis cis \glissandoSkipOff s1 \glissandoSkipOn cis4 \glissandoSkipOff \single \hideNotes cis2.
        s1 * 2 \glissandoSkipOn f4 f f f \glissandoSkipOff s1 \glissandoSkipOn f4 \glissandoSkipOff \single \hideNotes f2.
        s1 \glissandoSkipOn e4 e e e \glissandoSkipOff s1 \glissandoSkipOn e4 e e e \glissandoSkipOff \single \hideNotes e4 s2.
        s1 \glissandoSkipOn cis4 cis cis cis cis cis cis \glissandoSkipOff \single \hideNotes cis4
        s1 \glissandoSkipOn f4 f f f f8 \glissandoSkipOff \noBeam \single \hideNotes f8
        
      }{
        s1\< s1 * 2 s1\mf\> s1 *2
        s2\! s2\< s1 * 2 s2 s2\mf\> s1 * 2 s2 s2\!
        s4 s2.\< s1 * 2 s2. s4\mf\> s1 * 2 s2. s4\!
        s2 s2\< s1 * 2 s4 s2.\mf\> s1 s4 s2.\!
        s1\< s1 s4 s2.\mf\> s1 s4 s2.\!
        s1\< s2. s4\mf\> s1 *2 s4\! s2
        s4\< s1 s4\mf\> s2. s2. s4\!
        s4. s8\< s2 s1\mf\> s8 s8\!
      }
    >>

    \bar "||"

    % HARMONY
    <<
      {
        \time 4/4
        a 8\startGroup a gis c c b r \red cis,,~
        cis4 fis'8 fis fis f r \red f,~
        f8 gis' gis a a b b4
        \red e,,4 r8\stopGroup a'\startGroup a gis c c

        b8 r \red cis,,4~ cis8 fis' fis fis
        f8 r \red f,4 gis'8 gis a a
        b8 b4 \red e,,8~ e r8\stopGroup a'\startGroup a

        gis8 c c b r \red cis,,4.
        fis'8 fis fis f r \red f,4 gis'8
        gis8 a a b b4 \red e,,4

        r8\stopGroup a'\startGroup a gis c c b r
        \red cis,,4. fis'8 fis fis f r
        \red f,4 gis'8 gis a a b b~
        b8 \red e,,4 r8\stopGroup a'\startGroup a gis c
        c8 b r \red cis,,8~ cis4 fis'8 fis
        fis8 f r \red f,8~ f gis' gis a
        a8 b b4 \red e,,4 r8\stopGroup a'\startGroup

        a8 gis c c b r \red cis,,4~
        cis8 fis' fis fis f r \red f,4
        gis'8 gis a a
        b8 b4 \red e,,8~

        e r8\stopGroup a'\startGroup a gis c c b
        r8 \red cis,,4. fis'8 fis fis f
        r8 \red f,4 gis'8 gis a a
        b8 b4 \red e,,4 r8\stopGroup a'\startGroup a gis

        \time 2/4
        c8 c b r
        \bar "||"
      }
      \harmonyTempi
    >>

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