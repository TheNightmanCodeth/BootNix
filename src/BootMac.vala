public class BootNix : Gtk.Window{
    public BootNix(){
        //Set up window
        this.title = "BootNix";
        this.window_position=Gtk.WindowPosition.CENTER;
        this.destroy.connect (Gtk.main_quit);

        //Define UI Elements
        Gtk.Grid grid = new Gtk.Grid();
        this.add(grid);
        grid.column_spacing = 10;
        grid.row_spacing = 20;

        Gtk.TextView isoTextView = new Gtk.TextView();
        isoTextView.buffer.text = "Path to iso...";

        //widget, column(L/R), Row(Up/Down), Width, Height
        grid.attach(isoTextView, 0, 1, 20, 1);


        var chooseButton = new Gtk.Button.with_label ("Choose");
        grid.attach_next_to(chooseButton, isoTextView, Gtk.PositionType.RIGHT, 10, 1);
        chooseButton.clicked.connect (() => {

          //File chooser
          Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog("Choose file", this, Gtk.FileChooserAction.OPEN, "_Cancel", Gtk.ResponseType.CANCEL, "_Open", Gtk.ResponseType.ACCEPT);
          chooser.select_multiple = false;

          //Only choose ISOs
          Gtk.FileFilter filterISO = new Gtk.FileFilter();
          chooser.set_filter(filterISO);
          filterISO.add_mime_type("iso/iso");

          if(chooser.run() == Gtk.ResponseType.ACCEPT){

              string uri = chooser.get_uri();
              isoTextView.buffer.text = uri;

          }

          chooser.close();

        });
    }

    public static int main(string[] args){

        Gtk.init(ref args);

        BootNix bn = new BootNix();
        bn.show_all();
        Gtk.main();
        return 0;

    }
}
