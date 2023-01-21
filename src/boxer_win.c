#include <boxer/boxer.h>
#include <stdlib.h>
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <Windows.h>

#if defined(UNICODE)
static WCHAR* utf8ToUtf16(const char* utf8String)
{
   int count = MultiByteToWideChar(CP_UTF8, 0, utf8String, -1, NULL, 0);
   if (count <= 0)
   {
      return NULL;
   }

   WCHAR* utf16String = malloc(count * sizeof(WCHAR));
   if (MultiByteToWideChar(CP_UTF8, 0, utf8String, -1, utf16String, count) <= 0)
   {
      free(utf16String);
      return NULL;
   }

   return utf16String;
}
#endif // defined(UNICODE)

static UINT getIcon(BoxerStyle style)
{
   switch (style)
   {
   case BoxerStyleInfo:
      return MB_ICONINFORMATION;
   case BoxerStyleWarning:
      return MB_ICONWARNING;
   case BoxerStyleError:
      return MB_ICONERROR;
   case BoxerStyleQuestion:
      return MB_ICONQUESTION;
   default:
      return MB_ICONINFORMATION;
   }
}

static UINT getButtons(BoxerButtons buttons)
{
   switch (buttons)
   {
   case BoxerButtonsOK:
   case BoxerButtonsQuit: // There is no 'Quit' button on Windows :(
      return MB_OK;
   case BoxerButtonsOKCancel:
      return MB_OKCANCEL;
   case BoxerButtonsYesNo:
      return MB_YESNO;
   default:
      return MB_OK;
   }
}

static BoxerSelection getSelection(int response, BoxerButtons buttons)
{
   switch (response)
   {
   case IDOK:
      return buttons == BoxerButtonsQuit ? BoxerSelectionQuit : BoxerSelectionOK;
   case IDCANCEL:
      return BoxerSelectionCancel;
   case IDYES:
      return BoxerSelectionYes;
   case IDNO:
      return BoxerSelectionNo;
   default:
      return BoxerSelectionNone;
   }
}

BoxerSelection boxerShow(const char* message, const char* title, BoxerStyle style, BoxerButtons buttons)
{
   UINT flags = MB_TASKMODAL;

   flags |= getIcon(style);
   flags |= getButtons(buttons);

#if defined(UNICODE)
   const WCHAR* messageArg = utf8ToUtf16(message);
   if (!messageArg)
   {
      return BoxerSelectionError;
   }
   const WCHAR* titleArg = utf8ToUtf16(title);
   if (!titleArg)
   {
      free(messageArg);
      return BoxerSelectionError;
   }
#else
   const char* messageArg = message;
   const char* titleArg = title;
#endif

   BoxerSelection selection = getSelection(MessageBox(NULL, messageArg, titleArg, flags), buttons);

#if defined(UNICODE)
   free(messageArg);
   free(titleArg);
#endif // defined(UNICODE)

   return selection;
}
