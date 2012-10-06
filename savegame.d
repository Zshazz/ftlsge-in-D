import std.stream, std.stdio, std.exception;
import crew, event, helpers, system;

struct SaveGame {
	int[3] unknown;
	enum SystemType : uint {shield, engine, oxygen, weapon, drone, medbay, pilot, sensor, door, teleport, cloak};

	int verNum, /*unknown[0], */ numDefeated, numJumps, scrapCollected, numRecruited;
	string shipName, type;
	// unknown[1..3]
	int maxEvents;
	Event[] events;
	string type2, shipName2, shipClass;
	CrewBasicInfo[] startingCrew;
	int hull, missiles, fuel, droids, scrap;
	Crew[] currentCrew;
	// Systems:
	int reactorSize;
	System[SystemType.max + 1] systems;
	/+int[217] moreUnknown;
	int[30] closeToEquipment;+/
	//Future: Weapon[] equippedWeapons;

	byte[] restOfFile;

	void readFromFile(string filename) {
		auto inputFile = new BufferedFile(filename);
		readFromFile(inputFile);
		inputFile.close();
	}

	void writeToFile(string filename) {
		auto outputFile = new BufferedFile(filename, FileMode.OutNew);
		writeToFile(outputFile);
		outputFile.close();
	}

	void readFromFile(BufferedFile inputFile) {
		enforce(inputFile !is null);
		inputFile.read(verNum);
		enforce(verNum == 2, "The save file format is not 2!");

		inputFile.read(unknown[0]);

		inputFile.read(numDefeated);
		inputFile.read(numJumps);
		inputFile.read(scrapCollected);
		inputFile.read(numRecruited);

		shipName = readStringFrom(inputFile);
		type = readStringFrom(inputFile);

		inputFile.read(unknown[1]);
		inputFile.read(unknown[2]);

		events.readFromFile(inputFile);

		type2 = readStringFrom(inputFile);
		shipName2 = readStringFrom(inputFile);
		shipClass = readStringFrom(inputFile);

		startingCrew.readFromFile(inputFile);

		inputFile.read(hull);
		inputFile.read(fuel);
		inputFile.read(missiles);
		inputFile.read(droids);
		inputFile.read(scrap);

		currentCrew.readFromFile(inputFile);

		inputFile.read(reactorSize);

		foreach(ref system; systems)
			system.readFromFile(inputFile);

		/+foreach(ref elem; moreUnknown)
			inputFile.read(elem);

		foreach(ref elem; closeToEquipment)
			inputFile.read(elem);+/

		while(!inputFile.eof()) {
			ubyte a;
			inputFile.read(a);
			restOfFile ~= a;
		}
	}

	void writeToFile(BufferedFile outputFile) {
		enforce(outputFile !is null);
		outputFile.write(verNum);

		outputFile.write(unknown[0]);

		outputFile.write(numDefeated);
		outputFile.write(numJumps);
		outputFile.write(scrapCollected);
		outputFile.write(numRecruited);

		outputFile.write(shipName);
		outputFile.write(type);

		outputFile.write(unknown[1]);
		outputFile.write(unknown[2]);

		events.writeToFile(outputFile);

		outputFile.write(type2);
		outputFile.write(shipName2);
		outputFile.write(shipClass);

		startingCrew.writeToFile(outputFile);

		outputFile.write(hull);
		outputFile.write(fuel);
		outputFile.write(missiles);
		outputFile.write(droids);
		outputFile.write(scrap);

		currentCrew.writeToFile(outputFile);

		outputFile.write(reactorSize);

		foreach(system; systems)
			system.writeToFile(outputFile);

		/+foreach(elem; moreUnknown)
			outputFile.write(elem);

		foreach(elem; closeToEquipment)
			outputFile.write(elem);+/

		foreach(a; restOfFile) outputFile.write(a);
	}

	void print() {
		writeln("unkn[0]: ", unknown[0]);
		writeln("numDefeated: ", numDefeated);
		writeln("numJumps: ", numJumps);
		writeln("scrapCollected: ", scrapCollected);
		writeln("numRecruited: ", numRecruited);
		writeln("shipName: \"", shipName, "\"");
		writeln("type: \"", type, "\"");
		writeln("unkn[1]: ", unknown[1]);
		writeln("unkn[2]: ", unknown[2]);
		writeln(events);
		writeln("type2: \"", type2, "\"");
		writeln("shipName2: \"", shipName2, "\"");
		writeln("shipClass: \"", shipClass, "\"");
		writeln(startingCrew);
		writeln("hull: ", hull);
		writeln("fuel: ", fuel);
		writeln("missiles: ", missiles);
		writeln("droids: ", droids);
		writeln("scrap: ", scrap);
		writeln(currentCrew);
		writeln("reactorSize: ", reactorSize);
		writeln("Systems:");
		foreach(i, system; systems)
			writeln(" - ", cast(SystemType) i, ": ", system);
		/+writeln("moreUnkn:  ", moreUnkn);
		writeln("closeToEquipment: ", closeToEquipment);+/
	}
}
