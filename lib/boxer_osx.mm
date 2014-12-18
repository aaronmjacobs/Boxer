#include <boxer/boxer.h>
#import <Cocoa/Cocoa.h>

namespace boxer {

void show(const char *message, const char *title) {
   NSAlert *alert = [[NSAlert alloc] init];
   [alert addButtonWithTitle:@"OK"];
   [alert setMessageText:[NSString stringWithCString:title
                                   encoding:[NSString defaultCStringEncoding]]];
   [alert setInformativeText:[NSString stringWithCString:message
                                       encoding:[NSString defaultCStringEncoding]]];
   [alert setAlertStyle:NSWarningAlertStyle];

   [alert runModal];
   [alert release];
}

} // namespace boxer
