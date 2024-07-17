# E-commerce Application

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Prerequisites](#prerequisites)
5. [Setup](#setup)
6. [Running the Application](#running-the-application)
7. [User Roles](#user-roles)
8. [Admin Interface](#admin-interface)
9. [Shopping Cart](#shopping-cart)
10. [Checkout Process](#checkout-process)
11. [Homepage](#homepage)
12. [Testing](#testing)
13. [Deployment](#deployment)
14. [Contributing](#contributing)
15. [License](#license)

## Introduction

This is a Ruby on Rails e-commerce application that allows users to browse products, add them to a cart, complete purchases. It includes an admin interface for managing products, orders, users
and view basic analytics. The application features a responsive design using Tailwind CSS and includes user authentication and authorization.

## Features

- User authentication (sign up, log in, log out)
- Product browsing and searching
- Shopping cart functionality
- Checkout process
- Admin dashboard with analytics
- Product management (CRUD operations) for admins
- Order management for admins
- User management for admins
- Responsive design using Tailwind CSS

## Technologies Used

- Ruby 3.x
- Ruby on Rails 7.x
- PostgreSQL
- Tailwind CSS
- Devise (for authentication)
- Pundit (for authorization)
- Active Storage (for image uploads)
- Stimulus (for JavaScript interactions)
- Chart.js (for admin dashboard analytics)

## Prerequisites

Before you begin, ensure you have the following installed:

- Ruby 3.x
- Rails 6.x
- PostgreSQL
- Node.js and Yarn (for webpacker)

## Setup

1. Clone the repository:

   ```
   git clone https://github.com/Shoebtamboli/ecommerce_app.git
   cd ecommerce-app
   ```

2. Install dependencies:

   ```
   bundle install
   yarn install
   ```

3. Set up the database:

   ```
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Set up environment variables (if any) in a `.env` file.

## Running the Application

1. Start the Rails server:

   ```
   rails server
   ```

2. Visit `http://localhost:3000` in your web browser.

## Admin Interface

To access the admin interface:

1. Log in with an admin account (you can create one using the Rails console).
2. Visit `http://localhost:3000/admin/dashboard`.

The admin interface allows you to:

- View basic analytics (total products, out-of-stock products)
- Manage products (create, read, update, delete)

## User Roles

The application has two user roles:

1. Regular User: Can browse products, add to cart, and make purchases
2. Admin: Can access the admin interface and manage products, orders, and users

## Admin Interface

To access the admin interface:

1. Log in with an admin account (you can create one using the Rails console).
2. Visit `http://localhost:3000/admin/dashboard`.

The admin interface allows you to:

- View basic analytics (total products, out-of-stock products, total orders, total earnings)
- Manage products (create, read, update, delete)
- Manage orders (view, update status)
- Manage users (view, update, delete)

## Shopping Cart

- Users can add products to their cart from the product listing or detail pages
- Cart contents persist across sessions for logged-in users
- Users can update quantities or remove items from the cart

## Checkout Process

1. Users review their cart contents
2. Users proceed to checkout
3. Users enter shipping and payment information
4. Order is created and cart is cleared upon successful payment

## Homepage

The homepage features:

- A hero section with a call-to-action
- Featured product categories
- A selection of featured products

## Testing

To run the test suite:

```
rails test
```

## Deployment

(Add deployment instructions specific to your hosting platform)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.
