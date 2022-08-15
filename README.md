# purpose
### because of security limitation , browser can't run any `local` application/script from a web link by default .
Here use a protocol way to resolve this requirement.  
with this workhub, you can load any your local application / script with your customized parameter on your local windows system from a web link clicking, instead of downloading them.

# feature
it is used to load local application and script from a web link to improve daily work productivity.  
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
1. update the **localAppLoader.bat path** to your real local path in **localAppLoader_install.reg**
2. double-click file **localAppLoader_install.reg** to import it into your register.
   and ***verify*** it is imported sucessfully because some branches can't be imported successful, it needs your manual importing.
3. run the test file **test_install/localAppLoader_test.bat** or **test_install/localAppLoader_test.html**
   if test it with localAppLoader_test.html, to **click one link, one message will popup -- it is sucessfully**.
4. update the localAppLoader.bat based on your daily work business.
   the original localAppLoader.bat is my work hub script -- its nested/called script lies in the repo WinScript -- you can find them in my repo list. 

# example
  see below picture in my work scenarion:  
  https://github.com/shenxiaolong-code/DailyWorkHub/blob/main/my_work_hub_example.png

   

