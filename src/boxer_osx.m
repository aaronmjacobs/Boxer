#include <boxer/boxer.h>
#import <Cocoa/Cocoa.h>

#if defined(MAC_OS_X_VERSION_10_12) && MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_12
static const NSAlertStyle kInformationalStyle = NSAlertStyleInformational;
static const NSAlertStyle kWarningStyle = NSAlertStyleWarning;
static const NSAlertStyle kCriticalStyle = NSAlertStyleCritical;
#else
static const NSAlertStyle kInformationalStyle = NSInformationalAlertStyle;
static const NSAlertStyle kWarningStyle = NSWarningAlertStyle;
static const NSAlertStyle kCriticalStyle = NSCriticalAlertStyle;
#endif

#if defined(MAC_OS_X_VERSION_10_9) && MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_9
typedef NSModalResponse ModalResponse;
#elif defined(MAC_OS_X_VERSION_10_5) && MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_5
typedef NSInteger ModalResponse;
#else
typedef int ModalResponse;
#endif

static NSString* const kOkStr = @"OK";
static NSString* const kCancelStr = @"Cancel";
static NSString* const kYesStr = @"Yes";
static NSString* const kNoStr = @"No";
static NSString* const kQuitStr = @"Quit";

static NSAlertStyle getAlertStyle(BoxerStyle style)
{
   switch (style)
   {
   case BoxerStyleInfo:
      return kInformationalStyle;
   case BoxerStyleWarning:
      return kWarningStyle;
   case BoxerStyleError:
      return kCriticalStyle;
   case BoxerStyleQuestion:
      return kWarningStyle;
   default:
      return kInformationalStyle;
   }
}

static void setButtons(NSAlert* alert, BoxerButtons buttons)
{
   switch (buttons)
   {
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

static BoxerSelection getSelection(ModalResponse index, BoxerButtons buttons)
{
   switch (buttons)
   {
   case BoxerButtonsOK:
      return index == NSAlertFirstButtonReturn ? BoxerSelectionOK : BoxerSelectionNone;
   case BoxerButtonsOKCancel:
      if (index == NSAlertFirstButtonReturn)
      {
         return BoxerSelectionOK;
      }
      else if (index == NSAlertSecondButtonReturn)
      {
         return BoxerSelectionCancel;
      }
      else
      {
         return BoxerSelectionNone;
      }
   case BoxerButtonsYesNo:
      if (index == NSAlertFirstButtonReturn)
      {
         return BoxerSelectionYes;
      }
      else if (index == NSAlertSecondButtonReturn)
      {
         return BoxerSelectionNo;
      }
      else
      {
         return BoxerSelectionNone;
      }
   case BoxerButtonsQuit:
      return index == NSAlertFirstButtonReturn ? BoxerSelectionQuit : BoxerSelectionNone;
   default:
      return BoxerSelectionNone;
   }
}

BoxerSelection boxerShow(const char* message, const char* title, BoxerStyle style, BoxerButtons buttons)
{
   NSAlert* alert = [[NSAlert alloc] init];

   [alert setMessageText:[NSString stringWithUTF8String:title]];
   [alert setInformativeText:[NSString stringWithUTF8String:message]];

   [alert setAlertStyle:getAlertStyle(style)];
   setButtons(alert, buttons);

   // Force the alert to appear on top of any other windows
   [[alert window] setLevel:NSModalPanelWindowLevel];

   BoxerSelection selection = getSelection([alert runModal], buttons);
   [alert release];

   return selection;
}
