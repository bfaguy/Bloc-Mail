Capstone - Bloc-Mail 
====================
Capstone Project for Bloc. Manages Order Confirmation emails for customers. 


Purpose
-------
Create an application to allow users to manage customer service emails. Application will allow users to manage mailing lists and edit email campaigns.  

Background
----------
This is a book distribution company. We want to send three confirmation type emails to our customers.. Emails will be of three varities: 
1. confirm that an order has been received.
2. confirmed that an order is being processed / getting ready for shipment 
3. confirm that the order is shipped. 

All recipients should be subscribed to three email lists when they order from us. 
After they received the email campaigns fired to these three lists, they should be automatically unsubscribed. 


User Requirements
-----------------
- As a user, I should be able to view a list of all of my mailchimp lists. 
- As a user, I should be able to see all the members in each mailchimp list.
- As a user, I should be able to prune a mailchimp list remove stale email addresses.
    - 'stale' email addresses are defined as those that have received the email campaign already
- As a user, I should be able to edit email campaigns on mailchimp
- As a user, I want to see when was the l

### non-core requirements
- As a user, I can create and remove lists. 
- As a user, I should be able to login and logout of the system using my email address. 

Resources
---------
Will be using a ruby wrapper for the mailchimp api
