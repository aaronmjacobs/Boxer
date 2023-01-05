#include <boxer/boxer.h>
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <Windows.h>

static UINT getIcon(BoxerStyle style) {
   switch (style) {
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

static UINT getButtons(BoxerButtons buttons) {
   switch (buttons) {
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

static BoxerSelection getSelection(int response, BoxerButtons buttons) {
   switch (response) {
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

BoxerSelection boxerShow(const char *message, const char *title, BoxerStyle style, BoxerButtons buttons) {
   UINT flags = MB_TASKMODAL;

   flags |= getIcon(style);
   flags |= getButtons(buttons);

   return getSelection(MessageBox(NULL, message, title, flags), buttons);
}
