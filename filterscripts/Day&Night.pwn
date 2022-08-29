#include <a_samp>
#define FILTERSCRIPT
#define TIME 10

new Timer;
new Hour;
forward DayCycle();

public OnFilterScriptInit()
{
	Hour = 0;
	Timer = SetTimer("DayCycle", TIME*60*1000, true);
	print("   Day & Night FilterScript Loaded");
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(Timer);
	return 1;
}

public DayCycle()
{
	if(Hour != 23)
	{
		Hour++;
	}
	else
	{
		Hour = 0;
	}
	SetWorldTime(Hour);
	return 1;
}
