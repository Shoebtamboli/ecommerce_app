# E-commerce Application

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Prerequisites](#prerequisites)
5. [Setup](#setup)
6. [Running the Application](#running-the-application)
7. [Admin Interface](#admin-interface)
8. [User Roles](#user-roles)
9. [Testing](#testing)
10. [Deployment](#deployment)
11. [Contributing](#contributing)
12. [License](#license)

## Introduction

This is a Ruby on Rails e-commerce application that allows users to browse products, and administrators to manage products and view basic analytics. The application features a responsive design using Tailwind CSS and includes user authentication and authorization.

## Features

- User authentication (sign up, log in, log out)
- Product browsing for all users
- Admin dashboard with analytics
- Product management (CRUD operations) for admins
- Responsive design using Tailwind CSS

## Technologies Used

- Ruby 3.x
- Ruby on Rails 6.x
- PostgreSQL
- Tailwind CSS
- Devise (for authentication)
- Pundit (for authorization)

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

1. Regular User: Can browse products
2. Admin: Can access the admin interface and manage products

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
