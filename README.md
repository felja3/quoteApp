# Daily Quote App

This is a quote app with ability to store items in cloud.

<img width="379" height="768" alt="quote-ss" src="https://github.com/user-attachments/assets/5187287e-86fc-4bf2-b3d2-ba9674b5e97c" />

## Data

App takes data from pre-generated list of 100 quotes. They are stored as {quote, author} in quote.dart file

## Home Screen 
Initially, annonymous authentication sets new user based on device where opened.

On every opening of the app, one quote gets randomly from the list, stored as _currentQuote and shows on the screen through setState.

Home screen has : 
* Quote card
* New quote button
* Save button
* Favorite button

Quote - shows current quote

New quote - gets new item from list and assigns it to _currentQuote.

Save button - saves quotes to firestore of user. 

Favorite - navigates to new page where list of saved quotes

## Favorite screen 

On this screen list of saved user quotes is shown. If no quotes are yet saved then message will be shown, as well if where would be no connectivity to the firestore. 

Important point is that only current user quotes are loaded.

Firestore path for favorites:

users  
* current_user_uid  
* favorite_quotes

Every saved quote is one document inside favorite_quotes collection.

Each document has:
* quote
* author

Each quote is shown inside Card/ListTile and also has delete functionality. 

## Firestore Service

Firestore service is separate file that works with database. Following mvc pattern

It has functions for:
* Saving quote
* Getting favorite quotes
* Deleting quote

Main idea:

- Home screen calls save method when user presses Save button.
- Favorite screen listens to saved quotes and updates automatically when data changes.

## Anonymous Authentication

Anonymous authentication creates an users UID and checks current user. no login/sign-up

This UID is used to save and read users quotes from Firestore.
