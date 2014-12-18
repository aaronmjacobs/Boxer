#include <boxer/boxer.h>
#include <gtk/gtk.h>

namespace boxer {

void show(const std::string &message, const std::string &title) {
  gtk_init(0, NULL);

  GtkWidget *dialog = gtk_message_dialog_new(NULL,
            GTK_DIALOG_MODAL,
            GTK_MESSAGE_INFO,
            GTK_BUTTONS_OK,
            message.c_str());
  gtk_window_set_title(GTK_WINDOW(dialog), title.c_str());
  gtk_dialog_run(GTK_DIALOG(dialog));

  gtk_widget_destroy(GTK_WIDGET(dialog));
  while (g_main_context_iteration(NULL, false));
}

} // namespace boxer
