UIAlertViewWithSelectors
========================

An extension on UIAlertView that permits to assign a selector to each button. Is useful when have many alert views and every alert, after a user tap, executes a different method of a different class. Without this extension the easier way to get the same behaviour is implementing the UIAlertViewDelegate an ask for what alert view is calling the delegate and this is not scalable. 
