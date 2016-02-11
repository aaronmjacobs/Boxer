#include <boxer/boxer.h>

int main(int argc, char *argv[]) {
   boxerShow("Simple message boxes are very easy to create.", "Simple Example", kBoxerDefaultStyle, kBoxerDefaultButtons);

   boxerShow("There are a few different message box styles to choose from.", "Style Example", BoxerStyleError, kBoxerDefaultButtons);

   BoxerSelection selection;
   do {
      selection = boxerShow("Different buttons may be used, and the user's selection can be checked. Would you like to see this message again?", "Selection Example", BoxerStyleQuestion, BoxerButtonsYesNo);
   } while (selection == BoxerSelectionYes);

   return 0;
}
