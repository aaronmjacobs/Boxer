#include <boxer/boxer.h>

int main(int argc, char *argv[]) {
   boxer::show("Simple message boxes are very easy to create.", "Simple Example");

   boxer::show("There are a few different message box styles to choose from.", "Style Example", boxer::Style::Error);

   boxer::Selection selection;
   do {
      selection = boxer::show("Different buttons may be used, and the user's selection can be checked. Would you like to see this message again?", "Selection Example", boxer::Style::Question, boxer::Buttons::YesNo);
   } while (selection == boxer::Selection::Yes);

   return 0;
}
