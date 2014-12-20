/**
 * (C) Copyright 2004-2007 Shawn Betts
 * (C) Copyright 2007-2010 John J. Foerch
 * (C) Copyright 2007-2008 Jeremy Maitin-Shepard
 *
 * Use, modification, and distribution are subject to the terms specified in the
 * COPYING file.
**/

bind_scroll_keys(content_buffer_normal_keymap);
bind_selection_keys(content_buffer_normal_keymap);

// URL
define_key(content_buffer_normal_keymap, "u", "up");
define_key(content_buffer_normal_keymap, "l", "forward");
define_key(content_buffer_normal_keymap, "h", "back");
define_key(content_buffer_normal_keymap, "r", "reload");
define_key(default_global_keymap, "o", "find-url");
define_key(default_global_keymap, "O", "find-url-new-window");
define_key(content_buffer_normal_keymap, "e", "find-alternate-url");
define_key(content_buffer_normal_keymap, "p", "paste-url");
define_key(content_buffer_normal_keymap, "P", "paste-url-new-window");
define_key(content_buffer_normal_keymap, "C-x C-s", "save-page");
define_key(content_buffer_normal_keymap, "C-x h", "cmd_selectAll");

define_key(content_buffer_normal_keymap, "C-c", "stop-loading");

define_key(content_buffer_normal_keymap, "escape", "unfocus");

define_key(content_buffer_normal_keymap, "tab", "browser-focus-next-form-field");
define_key(content_buffer_normal_keymap, "S-tab", "browser-focus-previous-form-field");

// isearch (non-interactive)
define_key(content_buffer_normal_keymap, "S", "isearch-continue-forward");
define_key(content_buffer_normal_keymap, "R", "isearch-continue-backward");

define_key(content_buffer_normal_keymap, "C-x return c", "charset-prefix");
define_key(content_buffer_normal_keymap, "C-x return r", "reload-with-charset");

// multimedia keys
define_key(content_buffer_normal_keymap, "cmdback", "back");
define_key(content_buffer_normal_keymap, "cmdforward", "forward");
define_key(content_buffer_normal_keymap, "cmdreload", "reload");
define_key(content_buffer_normal_keymap, "cmdstop", "stop-loading");
define_key(content_buffer_normal_keymap, "cancel", "stop-loading");
define_key(content_buffer_normal_keymap, "cmdhome", "home");

// quickmarks
var quickmarks =
  { "gh" : "https://github.com/"
  , "rh" : "http://www.reddit.com/r/haskell"
  , "rp": "http://www.reddit.com/r/programming"
  , "soh": "http://stackoverflow.com/questions/tagged/haskell?sort=newest&pageSize=50"
  , "bb": "https://bitbucket.org/"
  , "hn": "https://news.ycombinator.com/"
  , "gm": "https://inbox.google.com/u/0/?pli=1"
  };

for(var qm in quickmarks) {
  interactive
    ("open-quickmark-" + qm,
     "Go to quickmark " + qm,
     "follow",
     $browser_object = quickmarks[qm]);
  define_key
    (content_buffer_normal_keymap,
     "g " + qm.split('').join(' '),
     "open-quickmark-" + qm);

  interactive
    ("open-quickmark-" + qm + "-new-window",
     "Go to quickmark " + qm,
     "find-url-new-window",
     $browser_object = quickmarks[qm]);
  define_key
    (content_buffer_normal_keymap,
     "G " + qm.split('').join(' '),
     "open-quickmark-" + qm + "-new-window");

}

define_key(content_buffer_normal_keymap, "C-z", content_buffer_normal_keymap);
