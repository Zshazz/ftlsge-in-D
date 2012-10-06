import std.stream;
import helpers;

struct CrewBasicInfo {
	string race, name;

	void readFromFile(BufferedFile inputFile) {
		race = readStringFrom(inputFile);
		name = readStringFrom(inputFile);
	}

	void writeToFile(BufferedFile outputFile) {
		outputFile.write(race);
		outputFile.write(name);
	}
}

struct Crew {
	int[2] unknown;
	enum SkillType : uint               {pilot, engine, shield, weapon, repair, combat};
	static immutable(uint[]) skillMax = [30,    30,     110,    130,    36,     16];

	string name, race;
	enum CrewType {person, drone};
	CrewType type;
	int health, x, y, room, room_tile;
	// unknown[0]
	int[SkillType.max + 1] skills;
	enum Gender {female, male};
	Gender gender;
	int numRepairs, numKills, numEvasions, numSkillMasteries;
	//unknown[1]

	void readFromFile(BufferedFile inputFile) {
		name = readStringFrom(inputFile);
		race = readStringFrom(inputFile);
		inputFile.read(cast(int)type);
		inputFile.read(health);
		inputFile.read(x);
		inputFile.read(y);
		inputFile.read(room);
		inputFile.read(room_tile);
		inputFile.read(unknown[0]);
		foreach(ref skill; skills)
			inputFile.read(skill);
		inputFile.read(cast(int)gender);
		inputFile.read(numRepairs);
		inputFile.read(numKills);
		inputFile.read(numEvasions);
		inputFile.read(numSkillMasteries);
		inputFile.read(unknown[1]);
	}

	void writeToFile(BufferedFile outputFile) {
		outputFile.write(name);
		outputFile.write(race);
		outputFile.write(cast(int)type);
		outputFile.write(health);
		outputFile.write(x);
		outputFile.write(y);
		outputFile.write(room);
		outputFile.write(room_tile);
		outputFile.write(unknown[0]);
		foreach(skill; skills)
			outputFile.write(skill);
		outputFile.write(cast(int)gender);
		outputFile.write(numRepairs);
		outputFile.write(numKills);
		outputFile.write(numEvasions);
		outputFile.write(numSkillMasteries);
		outputFile.write(unknown[1]);
	}
}
