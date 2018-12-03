Git
===

Git Introduction and other VCS
------------------------------

* Git is a powerful tool for distributed version control system. 
* The major difference between git and other VCS systems is the way they think 
  about "data". Most VCS store information as a list of file-based changes
  which is commonly known as delta-based version control. Git thinks of data as 
  a series of snapshots. Each time you commit, git 

  * saves the state of your project - Basically, takes a picture of what all
    your files look like at that moment and stores a reference to that snaphot
  * To be efficient, if files have not changed, Git doesn't store that file
    again, just a link to previous identical file it has already stored.

* When you do actions in git, you only add data to the git database.
* For the files tracked by git, it has three states where your file can reside
  in

  1. Committed - i.e. Your data is safely stored in local DB
  2. Modified - i.e. you have changed the file but not yet committed it to DB.
  3. Staged - i.e. you have marked a modified file in its current version to go
     into your next commit.


Git Configuration
-----------------

Git configuration can be stored in three different places

  1. /etc/gitconfig - Values applied to all users on the system (Use --system
     toption with `git config`)
  2. ~/.gitconfig or ~/.config/git/config - Values specific to a user (Use
     --global option with `git config`)
  3. .git/config file of your repository - Repository specific configuration.
     (Use --local option with `git config`, it is the default)

Each level overrides values in previous levels. Use `git config --list` to see
the list of current configurations.

Git Commands
------------

1. `git add <something>` tracks files 

2. `git commit -m "<some-message-here>"`

3. `git clone <url>` - Downloads a snashopt and does a checkout
  
     * `git clone <url> <folder_name>` - Clone the repo into `folder_name`
     * `git clone /path/to/a/git/repo/project.git` or `git clone
       file:///path/to/git/repo/project.git` Clone locally
     

4. `git status` - Tool to find which files are in which state
   `git status --short` or `git status -s` for crisp output

5. `git diff` - To see what have you changed but not yet staged? What have you
   staged that you are about to commit. 

     * `git diff` - Compares what is in your working directory with what is
       there in your staging area. The result tells you the changes you have
       made that you haven't yet staged.
     * `git diff --staged` or `git diff --cached` - What you have staged that
       will go into next commit.

6. `git commit` - Commit changes to local DB. The default commit message
   contains the latest output of `git status`.
     
     * `git commit -v` - To see the diff of your change in the editor. These
       are just for viewing, finally, git strips the comments and the diff.
     * `git commit -m <custom-message>` Inline commit message.
     * `git commit -a` - Automatically stage every file tracked before and
       commit letting you skip the `git add` part. Be careful, sometimes this
       flag will cause you to include unwanted changes.

7. `git rm <file-name>` - Removes your file from working directory as well as
   staging area. 

     * `git rm <dir_name>/\*.log` - Remove directories.
     * `git rm -f <file-name>` - Forcefully removes the file from working
       directory as well as staging area. It is to be used when the file
       `file-name` is in modified state.
     * `git rm --cached <file-name>` - Keep the file on disk but remove it from
       tracked files. This is particularly useful if you forgot to add some
       unwanted file to .gitignore

8. `git mv <file-from> <file-to>` - Rename a file

9. `git log` - View commit history in reverse chronological order (most recent
   commit first)

     * `git log -p -2` or `git log --patch -2` - Shows the difference
       introduced in each commit. You can also limit the number of log entries
       displayed.
     * `git log --stat` - To see some abbreviated statistics for each commit.
     * `git log --pretty=online` - To show outputs in different formats with 
       varying levels of information. `Oneline` gives one line per commit.
       Other useful options are `short`, `full`, `fuller` and `format`.
     * `git log --since=2.weeks` or `git log --since="2018-08-15"` or `git log
       --since="2 years 1 day 3 minutes ago"`
     * `git log --author=<author-name>` - Shows the commits of `<author-name>`
       only.
     * `git log --grep=<patterns>` - Shows commits containing these patterns.
     * `git log -S <some-string>` - Shows only those commits that changed the
       number of occurrences of that string (`<some-string>`)
     * `git log --oneline  --decorate --graph --all` - Shows various git
       branches and how they are connected through commits.

10. `git commit --amend` - Takes your staging area and uses it for the commit.
    This is to be used when you have committed "too early" and want to
    introduce few more changes to the exact same commit. You should use this
    option for small changes only (i.e. of the type "oops forgot to add this
    file" or "fixed a typo.")

11. `git reset HEAD <file>` - To unstage a staged file.

12. `git checkout -- <file>`- To unmodify a modified file, i.e. to revert the
    file back to what it looked like when you last committed. Note that this is
    a dangerous command as it changes your working directory. Any changes in
    the modified file are lost and cannot be recovered.
      
      * `git checkout -b <branch_name> <tag_name>` - To checkout a particular
        tagged version into a new branch.
      * `git checkout -b <branch_name>` - To create a new branch and switch to
        that branch.
      * `git checkout <branch_name>` - Goes to that branch. Note: changes your
        working directory.
      * `git checkout --track <remote_name>/<branch_name>` - Create and switch
        to a local branch `<branch_name>` which tracks
        `<remote_name>/<branch_name>`.
      * `git checkout <branch_name>` - Does the same thing as `git checkout 
        --track <remote_name>/<branch_name>` there are two conditions

          * `<branch_name>` does not exist locally.
          * Exactly matches the name on only one remote.

      * `git checkout -b <local_branch_name> <remote_name>/<server_branch_name>`
        - The `<local_branch_name>` now tracks `<server_branch_name>`


13. `git remote` - Shows the list of remotes.
    
      * `git remote -v` - Shows the list of remotes along with their URLs
      * `git remote add <remote_name> <remote_url>` - To add a new remote
      * `git remote show <remote_name>` - To see more information about a
        particular remote, including all the remote branches.
      * `git remote rename <remote_name_old> <remote_name_new>` to rename a
        remote. Therefore `remote_name_old/master` branch now becomes
        `remote_name_new/master`
      * `git remote add <local_proj_name> </path/to/local/repo/project.git>`

14. `git fetch <remote_name> [branch_name]` - Fetch all information that remote
    `<remote_name>` has but you don't. `<remote_name>`'s `branch_name` branch
    is available locally at `<remote_name>/<branch_name>`, you can merge it
    into one of your local branches or you can checkout a local branch if you
    want to inspect it.

15. `git push <remote_name> <branch_name>` Push your local branch to remote.
      
      * `git push <remote_name> <tag_name>` - To push tags to the shared
        servers
      * `git push <remote_name> --tags` - To push all the tags that are not yet
        there on the server.
      * `git push <remote_name> <branch_name>` - Push local branch
        `branch_name` to remote server's `remote_name:branch_name`.
      * `git push <remote_name> <local_branch_name:server_branch_name>`
      * `git push <remote_name> --delete <branch_name>` - To delete a remote
        branch.

16. `git pull <remote>` - Fetch from remote and merge it in current branch

      * `git pull --rebase`

17. `git tag` - List all available tags.

      * `git tag -l "v1.8.5"` - List tags containing v1.8.5.
      * `git tag -a <tag_name> -m "your message"` - Creates an annotated tag.
      * `git tag -a <tag_name> <commit_checksum>` - Tag one of the previous
        commits.
      * `git tag <tag_name>` - Create a lightweight tag (just like a branch, its
        a pointer to latest commit) 


18. `git show <tag_name>` - Show information about the particular tag.

19. `git branch` - Shows the list of branches in the current repo, also the
    current branch

      * `git branch <branch_name>` - Create a new branch
      * `git branch -d <branch_name>` - Deletes the particular branch. To be
        used for branches which are already merged with others.
      * `git branch -D <branch_name>` - Delete a branch even if the work in
        that branch isn't merged anywhere.
      * `git branch -r` - To see the list of remote branches.
      * `git branch -v` - To see the last commit on each branch.
      * `git branch --merged [optional_branch_name]` - List all branches that
        you have merged in your current branch.
      * `git branch --no-merged [optional_branch_name]` - List all branches
        which are not yet merged into your current branch.
      * `git branch -u <remote_name>/<branch_name>` - Make the current branch
        track an upstream branch on remote server. 
      * `git branch -u <remote_name>/<branch_name> <local_branch_name>` - This
        command will cause the `<local_branch>` to track the upstream branch
        `<remote_name>/<branch_name>`
        track an upstream branch on remote server. 
      * `git branch -vv` - To list all tracking branches that you have setup.


20. `git merge <branch_name>` - Merge the `branch_name` into the current
    branch. Manually resolve conflicts (if any)

      * `git merge <remote_name>/<branch_name>` - Merge the remote branch into
        current working branch.

21. `git rebase <branch_name>` - Play the changes of `<branch_name>` to your
    current branch.
      
      * `git rebase <base_branch> <topic_branch>` - checks out `topic_branch`
        and replay it on `base_branch`. Note that the `topic_branch`'s pointer
        moves forward and NOT `base_branch`'s pointer.
      * `git rebase --onto <branch1> <branch2> <branch3>` - Take `branch3`,
        figure out the patches since it diverged from `branch2`, replay these
        patches in `branch3` as if it was based directly off `branch1`
      * TIP 1: Do not rebase commits that exist outside your repository.
      * TIP 2: Rebase local changes you've made but haven't shared yet before
        you push them in order to clean up your story. Rebase your stuff before
        it is shared. 




Git Ignore
----------

* Ignore any files ending with ".o" or ".a" 
  `*.[oa]` 
* Ignore files ending with ".a" except lib.a
  `*.a`
  `!lib.a`
* Ignore TODO file in current directory (not subdirectories). Begin patterns 
  with forward slash are used to avoid recursivity
  `/TODO`
* Ignore all files in build directory. End patterns with backward slash to
  specify a directory 
  `build/`
* Ignore .txt files in doc folder
  `doc/*.txt`
* Ignore all pdf files in `doc/` directory or any of its subdirectories.
  `doc/**/*.pdf`
* More info @ `Sample .gitignore files <https://github.com/github/gitignore>`_
* Default behaviour is to have one .gitignore file per repo. But you can have
  one per folder.  The rules of nested .gitignore files apply only to the files
  under the directory where they are located. The linux kernel source
  repository has 206 .gitignore files!


Git on Server
-------------

A remote repository is a bare repo that has no working directory. It is only
used as a collaboration point, there is no reason to have a snapshot checked
out on disk. In short, a bare repository is the contents of .git directory and
nothing else.

