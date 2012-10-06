import std.stream;

public string readStringFrom(BufferedFile inputFile) {
	char[] strBuf;
	// Read length n, followed by n chars
	inputFile.read(strBuf);
	return strBuf.idup;
}

public void readFromFile(T)(ref T[] arr, BufferedFile inputFile) {
	uint len;
	inputFile.read(len);
	arr.length = len;

	foreach(ref elem; arr) elem.readFromFile(inputFile);
}

public void writeToFile(T)(ref T[] arr, BufferedFile outputFile) {
	outputFile.write(arr.length);

	foreach(elem; arr) elem.writeToFile(outputFile);
}
