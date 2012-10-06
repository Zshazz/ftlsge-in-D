import std.stream;

struct Event {
	string name;
	int value;

	void readFromFile(BufferedFile inputFile) {
		char[] str;
		inputFile.read(str);
		name = str.idup;
		inputFile.read(value);
	}

	void writeToFile(BufferedFile outputFile) {
		outputFile.write(name);
		outputFile.write(value);
	}
}
