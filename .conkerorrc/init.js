// Add $HOME/.conkerorrc to loadpath
let (path = get_home_directory()) {
  path.appendRelativePath(".conkerorrc");
  load_paths.unshift(make_uri(path).spec);
}

// Set $HOME/downloads as download directory
let (path = get_home_directory()) {
  path.appendRelativePath("downloads");
  cwd = make_file(path);
}

// Tell websites that we render like firefox
set_user_agent("Mozilla/5.0 (Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0");

// Use history
url_completion_use_history = true;

// Automatically follow selected hinting link after delay
var hints_auto_exit_delay = 500;

// Custom keybindings
user_pref("conkeror.load.bindings/default/bindings", 0);
require("keybindings/bindings");

var browser_default_open_target = OPEN_NEW_WINDOW;

// Middle mouse button
require("clicks-in-new-buffer.js");
var clicks_in_new_buffer_target = OPEN_NEW_WINDOW;

// Hide minibuffer
var minibuffer_autohide_message_timeout = 3000; //milliseconds to show messages
require("hide-minibuffer.js");

// URLs contain at least one dot, slash or colon
function possibly_valid_url (str) {
    return /^\s*[^\/\s]*(\/|\s*$)/.test(str)
        && /[:\/\.]/.test(str);
}

// Use google as default
read_url_handler_list = [read_url_make_default_webjump_handler("google")];

// Zathura for pdf
external_content_handlers.set("application/pdf", "zathura");
