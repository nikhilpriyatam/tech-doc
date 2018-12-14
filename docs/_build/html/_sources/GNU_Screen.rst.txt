==========
GNU Screen
==========

GNU Screen is a super useful command to NOT lose your work. Save the output of
your work in a file and split screens. The following are some of screen's
useful commands and functionalities.

+----------------------------------------+----------------------------------------------------+
| Functionality                          | Command                                            |
+----------------------------------------+----------------------------------------------------+
| Log the output of a particular program | `screen -L -Logfile <logfile_path> <your_command>` |
+----------------------------------------+----------------------------------------------------+
| Check the screen command version       | `(Ctrl + A) , v`                                   |
+----------------------------------------+----------------------------------------------------+
| Split screen vertically                | `(Ctrl + A) , (Shift + vertical bar)`              |
+----------------------------------------+----------------------------------------------------+
| Toggle screen                          | `(Ctrl + A) , Tab`                                 |
+----------------------------------------+----------------------------------------------------+
| See the number of active windows       | `(Ctrl + A) , w`                                   |
+----------------------------------------+----------------------------------------------------+
| Switch to a particular window          | `(Ctrl + A) , window_number`                       |
+----------------------------------------+----------------------------------------------------+
| To start shell in a new window         | `(Ctrl + A) , c`                                   |
+----------------------------------------+----------------------------------------------------+
| Kill a particular window               | `(Ctrl + A), k` press `y`                          |
+----------------------------------------+----------------------------------------------------+
| Kill a particular split                | `(Ctrl + A) , Q`                                   |
+----------------------------------------+----------------------------------------------------+
| Detach screen                          | `(Ctrl + A) , d`                                   |
+----------------------------------------+----------------------------------------------------+
| Create a new screen session            | `screen [-S OPTIONAL_SESSION_NAME]`                |
+----------------------------------------+----------------------------------------------------+
| Rename an existing screen session      | `(Ctrl + A) , :sessionname YOUR_SESSION_NAME`      |
+----------------------------------------+----------------------------------------------------+
| Re-attach a screen session             | `screen -r YOUR_SESSION_NAME`                      |
+----------------------------------------+----------------------------------------------------+


* Initially, I found some issues with background color of the shell and
  background color of vim, i.e they were looking different when opened inside
  GNU screen. Fix for that is very simple

  * Install the latest version (Version 4.99.0). More instructions are provided
    `here <https://stackoverflow.com/questions/6787734/strange-behavior-of-vim-color-inside-screen-with-256-colors>`_
  * Ensure that $TERM points to xterm-256color (Include it in ~/.bashrc also in
    ~/.screenrc or ~/.bash_profile)
  * Remember that if your $TERM is not pointing to xterm-256color and you ssh
    into another machine and then run screen on that machine, you will still
    see the colors differently. Therefore remember to set the $TERM variable
    almost everywhere

