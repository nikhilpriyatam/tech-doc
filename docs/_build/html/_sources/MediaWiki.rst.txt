MediaWiki
=========

* To allow uploading PDFs and other kind of files in mediawiki, go to the folder
  and edit the following file :code:`/var/www/html/mediawiki/LocalSettings.php`
  Change [or write]  the following line.

  * :code:`$wgFileExtensions = array( 'png', 'gif', 'jpg', 'jpeg', 'doc', 'xls',
    'mpp', 'pdf', 'ppt', 'tiff', 'bmp', 'docx', 'xlsx', 'pptx', 'ps', 'odt',
    'ods', 'odp', 'odg');`
  * :code:`sudo mkdir /var/www/html/mediawiki/images/temp`
  * :code:`sudo chmod -R 777 /var/www/html/mediawiki/images/`

* To increase the permissible file upload in mediawiki, change the following
  file :code:`/etc/php.ini`

  * :code:`upload_max_filesize = 20M`
  * :code:`post_max_size = 80M`   

* Use :code:`<br />` for inserting newline characters
