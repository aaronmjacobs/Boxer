#include <boxer/boxer.h>
#include <gtk/gtk.h>

static GtkMessageType getMessageType(BoxerStyle style) {
   switch (style) {
      case BoxerStyleInfo:
         return GTK_MESSAGE_INFO;
      case BoxerStyleWarning:
         return GTK_MESSAGE_WARNING;
      case BoxerStyleError:
         return GTK_MESSAGE_ERROR;
      case BoxerStyleQuestion:
         return GTK_MESSAGE_QUESTION;
      default:
         return GTK_MESSAGE_INFO;
   }
}

static GtkButtonsType getButtonsType(BoxerButtons buttons) {
   switch (buttons) {
      case BoxerButtonsOK:
         return GTK_BUTTONS_OK;
      case BoxerButtonsOKCancel:
         return GTK_BUTTONS_OK_CANCEL;
      case BoxerButtonsYesNo:
         return GTK_BUTTONS_YES_NO;
      default:
         return GTK_BUTTONS_OK;
   }
}

static BoxerSelection getSelection(gint response) {
   switch (response) {
      case GTK_RESPONSE_OK:
         return BoxerSelectionOK;
      case GTK_RESPONSE_CANCEL:
         return BoxerSelectionCancel;
      case GTK_RESPONSE_YES:
         return BoxerSelectionYes;
      case GTK_RESPONSE_NO:
         return BoxerSelectionNo;
      default:
         return BoxerSelectionNone;
   }
}

BoxerSelection boxerShow(const char *message, const char *title, BoxerStyle style, BoxerButtons buttons) {
   if (!gtk_init_check(0, NULL)) {
      return BoxerSelectionError;
   }

   // Create a parent window to stop gtk_dialog_run from complaining
   GtkWidget *parent = gtk_window_new(GTK_WINDOW_TOPLEVEL);

   GtkWidget *dialog = gtk_message_dialog_new(GTK_WINDOW(parent),
                                              GTK_DIALOG_MODAL,
                                              getMessageType(style),
                                              getButtonsType(buttons),
                                              "%s",
                                              message);
   gtk_window_set_title(GTK_WINDOW(dialog), title);
   BoxerSelection selection = getSelection(gtk_dialog_run(GTK_DIALOG(dialog)));

   gtk_widget_destroy(GTK_WIDGET(dialog));
   gtk_widget_destroy(GTK_WIDGET(parent));
   while (g_main_context_iteration(NULL, FALSE));

   return selection;
}
