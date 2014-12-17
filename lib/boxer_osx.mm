#include <boxer/boxer.h>
#import <Cocoa/Cocoa.h>

namespace boxer {

void show(const std::string &message, const std::string &title) {
   NSAlert *alert = [[NSAlert alloc] init];
   [alert addButtonWithTitle:@"OK"];
   [alert setMessageText:[NSString stringWithCString:title.c_str()
                                   encoding:[NSString defaultCStringEncoding]]];
   [alert setInformativeText:[NSString stringWithCString:message.c_str()
                                       encoding:[NSString defaultCStringEncoding]]];
   [alert setAlertStyle:NSWarningAlertStyle];

   [alert runModal];
   [alert release];
}

} // namespace boxer
