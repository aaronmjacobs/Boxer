#ifndef BOXER_H
#define BOXER_H

namespace boxer {

enum class Style {
   Info,
   Warning,
   Error,
   Question
};

enum class Buttons {
   OK,
   OKCancel,
   YesNo
};

enum class Selection {
   OK,
   Cancel,
   Yes,
   No,
   None
};

const Style DEFAULT_STYLE = Style::Info;
const Buttons DEFAULT_BUTTONS = Buttons::OK;

Selection show(const char *message, const char *title, Style style, Buttons buttons);

inline Selection show(const char *message, const char *title, Style style) {
   return show(message, title, style, DEFAULT_BUTTONS);
}

inline Selection show(const char *message, const char *title, Buttons buttons) {
   return show(message, title, DEFAULT_STYLE, buttons);
}

inline Selection show(const char *message, const char *title) {
   return show(message, title, DEFAULT_STYLE, DEFAULT_BUTTONS);
}

} // namespace boxer

#endif
