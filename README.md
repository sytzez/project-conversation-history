# Project Conversation History

> Keep track of you project's status updates!

This README serves as a quick and dirty design document for the app.

## Q&A

These questions were asked to my imaginary colleagues.

#### Does the app need to support more than one project?
No.

#### Are there a fixed number of statuses the project can have?
Yes.

#### What are those statuses?
Proposed, Planned, Cancelled, Early Development, On hold, Alpha, Beta, Live, Deprecated, End-of-life

#### Do there need to be user roles and permissions?
No.

#### Do users need to be able to reply to each other’s comments?
Not for now.

#### Should the project expose an API?
Not for now.

#### In the future, does the conversation history need to display different types of items than status changes or comments?
That is possible.

#### What details does a user’s profile need to have
A name and a role, both of which are free text fields.

#### Are those details mandatory?
Yes.

## Data model
From the task description and the Q&A above, the following concepts have arisen:

- **User**: A user can place comments or change the status of the project. Their profile is made up of a name field and a role field, both of which are required text fields.
- **Project**: There is only one project. The project is made up of all the existing comments and status updates. It doesn’t necessarily need its own database table.
- **Status update**: A change in the project’s status, made by a user. It would be nice to show it as a transition from an old to a new status (Except on the very first status update). It also needs to show the time it was changed.
- **Comment**: A user can leave comments. It needs to show a single text field, the author, and the time the comment was placed.
- **Conversation history**: The list of all comments and status updates in reverse chronological order. This does not need its own database table.
- **Conversation item**: An item in the project’s conversation history. Currently this can only be a status update or a comment, but it should be extensible. A history item needs to have a creation time and an author, and it needs to be able to render something to the history feed.

This leaves us with the following tables/models:
- User
  - email: text
  - conversation_items: hasMany
- ConversationItem
  - author: belongsTo(User)
  - created_at: datetime
  - item: hasOne(polymorphic)
- StatusUpdate
  - conversation_item: belongsTo
  - status: enum
- Comment
  - conversation_item: belongsTo
  - content: text

## Features

From the task description and the Q&A, the following user stories or features can be distilled:

- Create an account
  - When providing valid fields, it should log the user in and redirect to the conversation history.
  - When providing invalid fields, it should show validation errors.
- Log in
  - When providing valid credentials, it should log the user in and redirect to the conversation history.
  - When providing invalid credentials, it should show an error message.
- View the conversation history
  - It should show status updates and comments in reverse chronological order
  - It should show the date anb author for each conversation item
  - For comments, it should show the content
  - For status updates, it should show the old and the new status
- Update the project's status
  - It should add a status update item to the conversation history, and redirect the user to the conversation history.
- Place a comment
  - It should add the comment to the conversation history, and redirect the user to the conversation history.
