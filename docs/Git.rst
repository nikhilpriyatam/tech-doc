Git
===

* To do git pull while ignoring local changes, do the following:
  * :code:`git reset --hard`
  * :code:`git pull`
	
* Usual commands that I use to push to a git repository
  * :code:`git init` [If not done before]
  * :code:`git add .` [Add all the files, changes]
  * :code:`git commit -m "Some commit message here"`
  * :code:`git push -u origin master`
	
* To access previous versions in git you can use git checkout command.

* To see git commit history - :code:`git log`

* Usual command is git checkout commit_key
* :code:`git --work-tree=/Users/nikhilpattisapu/test checkout 33652e3da1da6dc8de7b731edebd9e96ad5aafae -- .` [To checkout the previous commit into a different folder]
* :code:`git ls-files`  [Show information about files in the index and the working tree]
* :code:`git reset --hard sha_commit_id` [To rollback to a previous commit]
* :code:`git rm -r folder_name` [To remove files that were earlier tracked by git]
* :code:`git remote -v` [To view information associated with remote repositories]
* :code:`git remote add short_name url` [To add a new remote Git repository as a short name. Usually, we use origin as a short name.]
* :code:`git remote remove short_name` [To remove a remote repository]
* :code:`git push --force origin master` . Ignores everything on remote repository and forcefully pushes the local stuff on remote. 
  * If you get error of the kind "You are not allowed to force push code to a protected branch on this project". 
  * Then go to the remote repository (gitlab / github). 
  * Go to Project Settings --> Protected Branches --> Unprotect. 
  * Re-execute the command and again protect the master branch by undoing the mentioned process"
* :code:`git config --global http.proxy http://proxy.iiit.ac.in:8080` [To make git work behind proxy use the following (IIIT Proxy)]
* :code:`git config --global --unset http.proxy` [To unest proxy]
* :code:`git config --global --get http.proxy` [To check the proxy]
* To include only "few specified files and directories" use the similar structure for :code:`.gitignore` as described below
