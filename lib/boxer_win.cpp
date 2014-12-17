#include <boxer/boxer.h>
#include <windows.h>

namespace boxer {

void show(const std::string &message, const std::string &title) {
   MessageBox(NULL, message.c_str(), title.c_str(), MB_OK);
}

} // namespace boxer
