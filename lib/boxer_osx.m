#include <boxer/boxer.h>
#import <Cocoa/Cocoa.h>

static NSString* const OK_STR = @"OK";
static NSString* const CANCEL_STR = @"Cancel";
static NSString* const YES_STR = @"Yes";
static NSString* const NO_STR = @"No";

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
         [alert addButtonWithTitle:OK_STR];
         break;
      case BoxerButtonsOKCancel:
         [alert addButtonWithTitle:OK_STR];
         [alert addButtonWithTitle:CANCEL_STR];
         break;
      case BoxerButtonsYesNo:
         [alert addButtonWithTitle:YES_STR];
         [alert addButtonWithTitle:NO_STR];
         break;
      default:
         [alert addButtonWithTitle:OK_STR];
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

   BoxerSelection selection = getSelection([alert runModal], buttons);
   [alert release];

   return selection;
}
