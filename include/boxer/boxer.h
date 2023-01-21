#ifndef BOXER_H
#define BOXER_H

#if defined(BOXER_DLL) && defined(BOXER_BUILD_DLL)
   /*!
    * BOXER_DLL must be defined by applications that are linking against the DLL version of the Boxer library.
    * BOXER_BUILD_DLL is defined when compiling the DLL version of the library.
    */
   #error "You may not have both BOXER_DLL and BOXER_BUILD_DLL defined"
#endif

/*!
 * BOXERAPI is used to declare public API classes / functions for export from the DLL / shared library / dynamic library
 */
#if defined(_WIN32) && defined(BOXER_BUILD_DLL)
   // We are building Boxer as a Win32 DLL
   #define BOXERAPI __declspec(dllexport)
#elif defined(_WIN32) && defined(BOXER_DLL)
   // We are calling Boxer as a Win32 DLL
   #define BOXERAPI __declspec(dllimport)
#elif defined(__GNUC__) && defined(BOXER_BUILD_DLL)
   // We are building Boxer as a shared / dynamic library
   #define BOXERAPI __attribute__((visibility("default")))
#else
   // We are building or calling Boxer as a static library
   #define BOXERAPI
#endif

/*!
 * Options for styles to apply to a message box
 */
typedef enum
{
   BoxerStyleInfo,
   BoxerStyleWarning,
   BoxerStyleError,
   BoxerStyleQuestion
} BoxerStyle;

/*!
 * Options for buttons to provide on a message box
 */
typedef enum
{
   BoxerButtonsOK,
   BoxerButtonsOKCancel,
   BoxerButtonsYesNo,
   BoxerButtonsQuit
} BoxerButtons;

/*!
 * Possible responses from a message box. 'BoxerSelectionNone' signifies that no option was chosen, and
 * 'BoxerSelectionError' signifies that an error was encountered while creating the message box.
 */
typedef enum
{
   BoxerSelectionOK,
   BoxerSelectionCancel,
   BoxerSelectionYes,
   BoxerSelectionNo,
   BoxerSelectionQuit,
   BoxerSelectionNone,
   BoxerSelectionError
} BoxerSelection;

/*!
 * The default style to apply to a message box
 */
static const BoxerStyle kBoxerDefaultStyle = BoxerStyleInfo;

/*!
 * The default buttons to provide on a message box
 */
static const BoxerButtons kBoxerDefaultButtons = BoxerButtonsOK;

/*!
 * Blocking call to create a modal message box with the given message, title, style, and buttons
 */
BOXERAPI BoxerSelection boxerShow(const char* message, const char* title, BoxerStyle style, BoxerButtons buttons);

#endif
