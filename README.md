Capstone Mailchimp
==================
Capstone Project for Bloc


Purpose
-------

Create an application to allow users to manage online mailing lists (hosted by mailchimp). Application will allow users to view mailing lists, see the current members on each list, and remove old email addreses from the list. Additionally, a batch job will run in the background to automatically remove outdated email addresses. 
Here is some background. The way we are using these email lists is to send confirmation type emails to recipients responding to the books they ordered. Emails will be of three varities: 1. confirm that an order has been received. 2. confirmed that an order is being processed / getting ready for shipment 3. confirm that the order is shipped. After the recipient receives the final email (#3), there is no need for her to remain on any of the emai lists. All recipients should be subscribed automatically to three email lists when they order from us. 


User Requirements
-----------------

- [ ] As a user, I should be able to view a list of all of my mailchimp lists. 
- [ ] As a user, I should be able to see all the members in each mailchimp list.
- [ ] As a user, I should be able to remove stale email addresses from each mailchimp list.

### batch job

### non-core requirements
- [ ] As a user, I can create and remove lists. 
- [ ] As a user, I should be able to login and logout of the system using my email address. 


Resources
---------
Will be using a ruby wrapper for the mailchimp api
Will use Rake to automate administrative tasks. Use Whenever gem to automate the rake tasks. 
