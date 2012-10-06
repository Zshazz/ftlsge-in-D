import std.stream;

struct System {
	int totalBars, activeBars;
	int[5] unknown;

	void readFromFile(BufferedFile inputFile) {
		inputFile.read(totalBars);
		if(totalBars == 0)
			return;

		inputFile.read(activeBars);
		foreach(ref e; unknown)
			inputFile.read(e);
	}

	void writeToFile(BufferedFile outputFile) {
		outputFile.write(totalBars);
		if(totalBars == 0)
			return;

		outputFile.write(activeBars);
		foreach(e; unknown)
			outputFile.write(e);
	}
}
