# Boxer

## Introduction

Boxer is a simple library that allows for easy cross-platform creation of message boxes / alerts / what have you.

## Example

OS X:

![OS X](http://i.imgur.com/ZUFGdSn.png)

Windows:

![Windows](http://i.imgur.com/brVJJw9.png)

Linux:

![Linux](http://i.imgur.com/BmzzdsW.png)

## Language

Boxer is written in C++, though it has a C branch available as well.

## Compiling Boxer

Boxer is set up to be built with CMake.

To generate a static library, execute CMake with the root of the repo as the source directory. Additionally, the example program can be built by enabling the BOXER_BUILD_EXAMPLES option.

On Linux, Boxer requires the gtk+-3.0 package.

## Including Boxer

Wherever you want to use Boxer, just include the header:

```c++
#include <boxer/boxer.h>
```

## Linking Against Boxer

### Static

If Boxer was built statically, just link against the generated static library.

### CMake

To compile Boxer along with another application using CMake, first add the Boxer subdirectory:

```cmake
add_subdirectory("path/to/Boxer")
```

Then link against the Boxer library:

```cmake
target_link_libraries(<target> <INTERFACE|PUBLIC|PRIVATE> Boxer)
```

## Using Boxer

To create a message box using Boxer, call the 'boxerShow' method and provide a message, title, style, and buttons:

```c
boxerShow("Simple message boxes are very easy to create.", "Simple Example", kBoxerDefaultStyle, kBoxerDefaultButtons);
```

Different styles / buttons may be specified, and the user's selection can be determined from the function's return value:

```c
BoxerSelection sel = boxerShow("Make a choice:", "Decision", BoxerStyleWarning, BoxerButtonsYesNo);
```

Calls to 'show' are blocking - execution of your program will not continue until the user dismisses the message box.
