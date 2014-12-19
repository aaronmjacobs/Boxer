#include <boxer/boxer.h>
#import <Cocoa/Cocoa.h>

namespace boxer {

namespace {

NSString* const OK_STR = @"OK";
NSString* const CANCEL_STR = @"Cancel";
NSString* const YES_STR = @"Yes";
NSString* const NO_STR = @"No";

NSAlertStyle getAlertStyle(Style style) {
   switch (style) {
      case Style::Info:
         return NSInformationalAlertStyle;
      case Style::Warning:
         return NSWarningAlertStyle;
      case Style::Error:
         return NSCriticalAlertStyle;
      case Style::Question:
         return NSWarningAlertStyle;
      default:
         return NSInformationalAlertStyle;
   }
}

void setButtons(NSAlert *alert, Buttons buttons) {
   switch (buttons) {
      case Buttons::OK:
         [alert addButtonWithTitle:OK_STR];
         break;
      case Buttons::OKCancel:
         [alert addButtonWithTitle:OK_STR];
         [alert addButtonWithTitle:CANCEL_STR];
         break;
      case Buttons::YesNo:
         [alert addButtonWithTitle:YES_STR];
         [alert addButtonWithTitle:NO_STR];
         break;
      default:
         [alert addButtonWithTitle:OK_STR];
   }
}

Selection getSelection(int index, Buttons buttons) {
   switch (buttons) {
      case Buttons::OK:
         return index == NSAlertFirstButtonReturn ? Selection::OK : Selection::None;
      case Buttons::OKCancel:
         if (index == NSAlertFirstButtonReturn) {
            return Selection::OK;
         } else if (index == NSAlertSecondButtonReturn) {
            return Selection::Cancel;
         } else {
            return Selection::None;
         }
      case Buttons::YesNo:
         if (index == NSAlertFirstButtonReturn) {
            return Selection::Yes;
         } else if (index == NSAlertSecondButtonReturn) {
            return Selection::No;
         } else {
            return Selection::None;
         }
      default:
         return Selection::None;
   }
}

} // namespace

Selection show(const char *message, const char *title, Style style, Buttons buttons) {
   NSAlert *alert = [[NSAlert alloc] init];

   [alert setMessageText:[NSString stringWithCString:title
                                   encoding:[NSString defaultCStringEncoding]]];
   [alert setInformativeText:[NSString stringWithCString:message
                                       encoding:[NSString defaultCStringEncoding]]];

   [alert setAlertStyle:getAlertStyle(style)];
   setButtons(alert, buttons);

   Selection selection = getSelection([alert runModal], buttons);
   [alert release];

   return selection;
}

} // namespace boxer
