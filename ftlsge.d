import std.stdio;
import savegame, crew;

void main() {
	string inputName = "continue.sav", outputName = "continue.sav.new";
	SaveGame sg;
	sg.readFromFile(inputName);

	sg.droids   =  500;
	sg.fuel     =  500;
	sg.missiles =  500;
	sg.scrap    = 5000;

	sg.reactorSize = 36;
	with(SaveGame.SystemType) {
		sg.systems[shield].totalBars =  8;
		sg.systems[engine].totalBars =  8;
		sg.systems[weapon].totalBars = 12;
		sg.systems[oxygen].totalBars =  3;
		sg.systems[medbay].totalBars =  3;
		sg.systems[pilot].totalBars  =  3;
		sg.systems[sensor].totalBars =  3;
		sg.systems[door].totalBars   =  3;

		sg.systems[drone].totalBars    = 7;
		sg.systems[teleport].totalBars = 3;
		sg.systems[cloak].totalBars    = 4;
	}

	sg.nearlyMaxOutCrew();

	//sg.print();
	sg.writeToFile(outputName);
}

// For convenience...

void nearlyMaxOutCrew(SaveGame saveInfo) {
	foreach(ref member; saveInfo.currentCrew)
	foreach(type, ref skill; member.skills) {
		if(skill < Crew.skillMax[type]) {
			skill = Crew.skillMax[type] - 1;
		}
	}
}
