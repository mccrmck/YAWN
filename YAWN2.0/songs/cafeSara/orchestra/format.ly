\version "2.24.2"

% only spacers and breaks, no time signatures or barlines!
\include "scaledBars.ly"

scoreFormat = \new NullVoice {
  \mark \markup { "LASTB" }
  s1 * 3
  s2
  \break

  \mark \markup { "DOOM" }
  \repeat unfold 3 {
    s2.
    s1
    s1
    s4. * 3
  }
  \break

  \mark \markup { "AMBIENCE" }
  s1 * 7 \break
  s1 * 6 \break
  s1 * 7 \break
  s1 * 7 \break
  s1 * 6 \break
  s1 * 5 \break
  s1 * 4 \break
 
  \mark \markup { "HARMONY" }
  s1 * 5 \break
  s1 * 6 \break
  \mark \markup { "P.M." }
  s1 * 2
  s8 \mark \markup { "P.M." } s4. s2
  s1 \break
  s1
  s2 \mark \markup { "Zipper" } s2
  s1 * 4 \break
  s2 \mark \markup { "8va." }  s2
  s1 * 2
  s2
  \break

  \mark \markup { "PANTERA" }
  s1 * 8

}

doomTempi = \new Voice {}

harmonyTempi = \new Voice {
  \repeat unfold 4 {
    \tempoArrow 2 "140" { \endSpanners s1\startTextSpan }
    \tempoArrow 2 "100" { \endSpanners s1\startTextSpan }
    \tempoArrow 2 "80"  { \endSpanners s1\startTextSpan }
    \tempoArrow 2 "120" { \endSpanners s1\startTextSpan }
  }
  \tempoArrow 2 "142.5" { \endSpanners s1\startTextSpan }
  \tempoArrow 2 "100"   { \endSpanners s1\startTextSpan }
  \tempoArrow 2 "77.5"  { \endSpanners s1\startTextSpan }
  \tempoArrow 2 "120"   { \endSpanners s1\startTextSpan }

  \tempoArrow 2 "145"   { \endSpanners s1\startTextSpan }
  \tempoArrow 2 "100"   { \endSpanners s1\startTextSpan }
  \tempoArrow 2 "75"    { \endSpanners s1\startTextSpan }
  \tempoArrow 2 "145"   { \endSpanners s1\startTextSpan }

  \tempoToTempo 2 "145" "130" { \endSpanners s4\startTextSpan s4\stopTextSpan }
}

panteraTempi = \tempo 4 = 90