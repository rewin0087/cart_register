# README

## Technical Evaluation Amenitiz

## Problem to Solve
You are the developer in charge of building a cash register. This app will be able to add products to a cart and display the total price.

### Objective
Build an application prototype responding to these needs.

### By prototype, we mean:
●	It is usable while remaining as simple as possible,

●	We place little emphasis on the visual,

●	We do not expect complexity that does not meet the primary functional need of the app. Technical requirements

●	A web interface (even minimalist), ● Built-in Ruby on Rails, ● Covered by tests. Bonus

●	Using React,

●	Following TDD methodology.
 
●	The CEO is a big fan of buy-one-get-one-free offers and green tea. He wants us to add a rule to do this.

●	The COO, though, likes low prices and wants people buying strawberries to get a price discount for bulk purchases. If you buy 3 or more strawberries, the price should drop to 4.50€.

●	The VP of Engineering is a coffee addict. If you buy 3 or more coffees, the price of all coffees should drop to 2/3 of the original price.
Our check-out can scan items in any order, and because the CEO and COO change their minds often, it needs to be flexible regarding our pricing rules.
 
### Deliverable
● The codebase in a public git repository, ● The app: online on a custom server.

Things we are going to look into or ask about

●	Best practices

●	Commit history

●	Code structure and flow

●	Flexible structure that can be easily adapted for future changes 
● To make some changes to the code.
<img width="442" height="655" alt="image" src="https://github.com/user-attachments/assets/8094f44f-b10d-48c4-8afe-f14a43348342" />

## Setup & Start app
```
bundle install
bundle exec rake db:create db:migrate db:seed
bin/dev
```
### Run test
```
bundle exec rspec spec
```

### Recommendation

- Migrate UI to reactjs or nextjs
- Perform checkout from cart (next process payment and shipping details)
- Backoffice admin interface to manage product
- Inventory for product to limit available item per product to checkout
- User indentity and user management
- Images and preview of product details
- For interactive UI
- Scalable Product list (no pagination at the moment)
