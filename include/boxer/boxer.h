#ifndef BOXER_H
#define BOXER_H

typedef enum {
   BoxerStyleInfo,
   BoxerStyleWarning,
   BoxerStyleError,
   BoxerStyleQuestion
} BoxerStyle;

typedef enum {
   BoxerButtonsOK,
   BoxerButtonsOKCancel,
   BoxerButtonsYesNo
} BoxerButtons;

typedef enum {
   BoxerSelectionOK,
   BoxerSelectionCancel,
   BoxerSelectionYes,
   BoxerSelectionNo,
   BoxerSelectionNone
} BoxerSelection;

static const BoxerStyle BOXER_DEFAULT_STYLE = BoxerStyleInfo;
static const BoxerButtons BOXER_DEFAULT_BUTTONS = BoxerButtonsOK;

BoxerSelection boxerShow(const char *message, const char *title, BoxerStyle style, BoxerButtons buttons);

#endif
