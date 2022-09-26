# purpose
Integrate all launch entries in one page, one-click to open any local application , local script, local file and remote url in browser page , instead of downloading them.
### because of security limitation , browser can't run any `local` application/script from a web link by default .
Here use a protocol way to resolve this requirement.  
with this workhub, you can load any your local application / script with your customized parameter on your local windows system from a web link clicking, instead of downloading them.

# dependency
this project need the support of winscript.  
https://github.com/shenxiaolong-code/WinScript/tree/master/common

# feature
it is used to load local application and script from a web link to improve daily work productivity.  
the full script suite includes `.js file` , `.css file` , `xiaolong's chrome extension` , `subcommand interpreter (batch script)`. it will generate below content automatically.
- page header info, used for quick edit and open general tools.
- embed css style , auto-dark mode.
- for all remote link , add `targe="_blank"` attribute to open it in new tab.
- for local .txt file path, add edit link (@) and directory browse link to quick edit it and browse its folder.   
  see https://github.com/shenxiaolong-code/DailyWorkHub/blob/main/usage_demo/entry_main_page.png
- trim blank chars in a link text.
- detect empty link text and add it automatically. e.g. you can use the below HTML content legally and directly.  
  ```<a href="C:\temp\DailyWorkHub\localAppLoader.bat"> </a>```   
  it will use the href value as its link text.
- for any html tag which has ``localurl`` attribute, generate two children elements : file link and directory link.  
  e.g. ```<div localurl="C:\temp\DailyWorkHub\localAppLoader.bat"><div>```
- embed quick edit,vscodeEdit, open , defaultOpen , vscodeOpen ,explorerOpen , explorerLocate button when open a windows local folder in chrome.  
  see https://github.com/shenxiaolong-code/DailyWorkHub/blob/main/usage_demo/local_file_system.png

By click the link , you can do :
- open your local folder, instead of listing its folder content.
- open/edit a local file by your expected application directly, instead of popuping a downloading message box to confirm download.
- run a local script/application with parameter or from your clipboard data.
- connect remote linux folder via local vscode directly.
- connect remote server via ssh protocol directly.
- open remote linux folder via winscp directly.
- connect remote linux server via vnc directly without vnc viewer.
- connect remote windows desktop via windows RDP services directly without manual interaction.

# Usage
you need to do:
1. update the `localAppLoader.bat path` to your real local path in `localAppLoader_install.reg`  
2. double-click file `localAppLoader_install.reg` to import it into your register, and `verify` it is imported sucessfully.   
   because of windows security limit, some branches can't be imported successful -- it needs your manual importing.
3. run the test file `test_install/localAppLoader_test.bat` or `test_install/localAppLoader_test.html`  
   if test it with localAppLoader_test.html, `click one link, one message will popup -- it is sucessfully`.
4. update the localAppLoader.bat based on your daily work business.  
   the original localAppLoader.bat is my work hub script -- the embeded/called script lies in my WinScript repo.  
   you can find them : https://github.com/shenxiaolong-code/WinScript/tree/master/common

# example
  see below picture in my work scenarion:  
  https://github.com/shenxiaolong-code/DailyWorkHub/tree/main/usage_demo

   

