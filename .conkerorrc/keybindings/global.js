/**
 * (C) Copyright 2004-2007 Shawn Betts
 * (C) Copyright 2007,2010 John J. Foerch
 * (C) Copyright 2007-2008 Jeremy Maitin-Shepard
 *
 * Use, modification, and distribution are subject to the terms specified in the
 * COPYING file.
**/

define_key(default_help_keymap, "a", "apropos-command");
define_key(default_help_keymap, "b", "describe-bindings");
define_key(default_help_keymap, "f", "describe-command");
define_key(default_help_keymap, "v", "describe-variable");
define_key(default_help_keymap, "k", "describe-key");
define_key(default_help_keymap, "c", "describe-key-briefly");
define_key(default_help_keymap, "p", "describe-preference");
define_key(default_help_keymap, "i", "help-page");
define_key(default_help_keymap, "t", "tutorial");
define_key(default_help_keymap, "w", "where-is");

define_key(default_base_keymap, "f1", default_help_keymap);


define_key(sequence_help_keymap, "C-h", "describe-active-bindings");
define_key(sequence_abort_keymap, "C-g", "sequence-abort");


/**
 * default_global_keymap
 */
define_key(default_global_keymap, "C-z", default_global_keymap);

define_key(default_global_keymap, "M-x", "execute-extended-command");
define_key(default_global_keymap, "M-:", "eval-expression");
define_key(default_global_keymap, "M-!", "shell-command");


define_key(default_global_keymap, "w", "make-window");
define_key(default_global_keymap, "d", "delete-window");
define_key(default_global_keymap, "/", "isearch-forward");
define_key(default_global_keymap, "C-r", "isearch-backward");
define_key(default_global_keymap, "f11", "toggle-full-screen");

// multimedia keys
define_key(default_global_keymap, "cmdsearch", "isearch-forward");

define_key(default_global_keymap, "C-x %", "image-toggle-zoom-to-fit");
