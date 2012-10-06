#FTL: Faster Than Light - Save Game Editor

License: WTFPL
Written by Zshazz

##Requirements
[dmd 2.060 from dlang.org](http://dlang.org/ "Home - D Programming Language")

##How to compile/run
A Makefile is included to make it easy to compile ftlsge with rdmd. Assuming you have dmd installed, you should have rdmd and the makefile will work correctly. After compilation is completed, run the ftlsge executable generated.
As an alternative: if desired, you can simply run the application through the command-line by invoking `rdmd ftlsge.d` in the directory the source files are.

##How to use
Currently, there is no user interface. However, most of the settings are easily manipulated in code. Modify ftlsge.d to produce the desired modifications to your save game.
1. Locate your FasterThanLight `continue.sav`. It's usually located in `My Documents\My Games\FasterThanLight`
2. Place your `continue.sav` into the directory you will run ftlsge in.
3. Run ftlsge
4. Copy the `continue.sav.new` and use it to replace the `continue.sav` in your `My Documents\My Games\FasterThanLight` directory.

##Future work
- Discover the purposes of all of the currently unknown sections. The inventory system is nearly within sight, but there's a lot of unknown space to discover between it and the subsystem information.
- Most things are an int... however, it's unclear if these are always going to be 32-bit ints. According to posts on the internet, it seems like this code might not work with some versions of FTL which might be compiled for x86-64.
- [As per the Ddocs](http://dlang.org/phobos/std_stream.html), std.stream will be depreciated soon, so switch to the alternative whenever it is released.
