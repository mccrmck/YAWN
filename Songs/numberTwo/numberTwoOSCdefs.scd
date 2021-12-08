///////////////////////////////////////////////// YAWN oscDefs: numberFour /////////////////////////////////////////////////

(
// impro setup...samples?



// turn click on & off

OSCdef(\numberOneClick,{ |msg, time,addr, recvPort|
	var val = msg[1];

	case
	{val == 0}{ /* start click */ }
	{val == 1}{ /* cueTorfinn */	};
	{val == 2}{ /* fusion */ }
	{val == 3}{ /* outro */ }

},'/numberOne/click/x');
)


