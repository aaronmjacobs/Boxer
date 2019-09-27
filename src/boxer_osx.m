#include <boxer/boxer.h>
#import <Cocoa/Cocoa.h>

static NSString* const kOkStr = @"OK";
static NSString* const kCancelStr = @"Cancel";
static NSString* const kYesStr = @"Yes";
static NSString* const kNoStr = @"No";
static NSString* const kNoStr = @"Quit";

static NSAlertStyle getAlertStyle(BoxerStyle style) {
   switch (style) {
      case BoxerStyleInfo:
         return NSInformationalAlertStyle;
      case BoxerStyleWarning:
         return NSWarningAlertStyle;
      case BoxerStyleError:
         return NSCriticalAlertStyle;
      case BoxerStyleQuestion:
         return NSWarningAlertStyle;
      default:
         return NSInformationalAlertStyle;
   }
}

static void setButtons(NSAlert *alert, BoxerButtons buttons) {
   switch (buttons) {
      case BoxerButtonsOK:
         [alert addButtonWithTitle:kOkStr];
         break;
      case BoxerButtonsOKCancel:
         [alert addButtonWithTitle:kOkStr];
         [alert addButtonWithTitle:kCancelStr];
         break;
      case BoxerButtonsYesNo:
         [alert addButtonWithTitle:kYesStr];
         [alert addButtonWithTitle:kNoStr];
         break;
      case BoxerButtonsQuit:
         [alert addButtonWithTitle:kQuitStr];
         break;
      default:
         [alert addButtonWithTitle:kOkStr];
   }
}

static BoxerSelection getSelection(int index, BoxerButtons buttons) {
   switch (buttons) {
      case BoxerButtonsOK:
         return index == NSAlertFirstButtonReturn ? BoxerSelectionOK : BoxerSelectionNone;
      case BoxerButtonsOKCancel:
         if (index == NSAlertFirstButtonReturn) {
            return BoxerSelectionOK;
         } else if (index == NSAlertSecondButtonReturn) {
            return BoxerSelectionCancel;
         } else {
            return BoxerSelectionNone;
         }
      case BoxerButtonsYesNo:
         if (index == NSAlertFirstButtonReturn) {
            return BoxerSelectionYes;
         } else if (index == NSAlertSecondButtonReturn) {
            return BoxerSelectionNo;
         } else {
            return BoxerSelectionNone;
         }
      default:
         return BoxerSelectionNone;
   }
}

BoxerSelection boxerShow(const char *message, const char *title, BoxerStyle style, BoxerButtons buttons) {
   NSAlert *alert = [[NSAlert alloc] init];

   [alert setMessageText:[NSString stringWithCString:title
                                   encoding:[NSString defaultCStringEncoding]]];
   [alert setInformativeText:[NSString stringWithCString:message
                                       encoding:[NSString defaultCStringEncoding]]];

   [alert setAlertStyle:getAlertStyle(style)];
   setButtons(alert, buttons);

   // Force the alert to appear on top of any other windows
   ProcessSerialNumber psn = { 0, kCurrentProcess };
   TransformProcessType(&psn, kProcessTransformToUIElementApplication);
   [[alert window] makeKeyWindow];

   BoxerSelection selection = getSelection([alert runModal], buttons);
   [alert release];

   return selection;
}
