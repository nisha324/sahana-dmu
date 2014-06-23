# Sahana - DMU


Vesuvius modification to be used by Disaster Preparedness and Response Division, Ministry of Health, Sri Lanka. Developed by Virtusa Pvt Ltd.

## Installation Instructions:

### On Windows systems
- Install an Apache server stack. (XAMPP or WAMP is recommended)
- Follow the instructions in the INSTALL file in your checked out code to get a local instance of Vesuvius up and running.
- ```.htaccess``` file:
  - If you are using XAMPP or WAMP, editing your ```apache.conf``` file and enabling mod_rewrite will enable the rewrite module for .htaccess.
  - Editing httpd.conf and setting AllowOverride All in the root folder section will prevent errors.
- You will also need to edit the php.ini in XAMPP or WAMP and set the ```short_open_tags``` option to ```On```. 

### On Linux systems

- Install an Apache server stack. (LAMP)
- Follow the instructions in the ```INSTALL``` file in your checked out code to get a local instance of Vesuvius up and running.
- ```.htaccess``` file:
  - Enable apache2 mod rewrite using the command ```sudo a2enmod rewrite```
  - ```/etc/apache2/apache2.conf``` file needs to have ```AllowOverride``` set to ```All``` under the ```DocumentRoot``` section
- You might also need to edit the php.ini in your Apache PHP installation and set the ```short_open_tags``` option to ```On```. 
