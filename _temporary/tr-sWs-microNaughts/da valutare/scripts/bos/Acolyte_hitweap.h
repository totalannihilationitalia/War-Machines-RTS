// Acolyte Hit-Weapon Script by Blackthorn of TADD

#ifndef __HITWEAP_H_
#define __HITWEAP_H_

HitByWeapon(anglex,anglez)
	{
		if (nrgychk == 0)
			{
			sleep 1;
			}		

		if (nrgychk == 1)
			{
			show blood;
			explode blood type	SHATTER|;
			hide blood;
			sleep1;
			}
	}

#endif
