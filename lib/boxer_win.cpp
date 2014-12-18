#include <boxer/boxer.h>
#include <windows.h>

namespace boxer {

void show(const char *message, const char *title) {
   MessageBox(NULL, message, title, MB_OK);
}

} // namespace boxer
