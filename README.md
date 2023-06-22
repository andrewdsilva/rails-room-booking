<p align="center">
  <img src="app/assets/images/logo.svg" alt="Rails Room Booking" width="120">
</p>

<h3 align="center">Rails Room Booking</h3>

Open-source solution for hotel and vacation rental management, offering online reservation processes, and secure online payment transactions.

![Screenshot](./app/assets/images/screenshot.png)

___

## Features ✅

- **Sign up / Log in**: Simply create an account or log in to access the platform.

- **Management of your homes**: Effortlessly handle your property portfolio, including adding, editing, and managing various details such as property descriptions, options, and pricing.

- **Online booking**: Enable your customers to easily make reservations for your accommodations directly through the platform, streamlining the booking process for a seamless user experience.

- **Account settings**: Management of your preferences (VAT rates, etc.)

- **Online payment via Stripe**: Facilitate secure online payments by integrating with Stripe, a trusted payment gateway, allowing your users to make payments conveniently and securely.

## Upcoming features 🚀

- **Synchronization of availability with Airbnb**: Automatically synchronize the availability of your accommodations with Airbnb, ensuring consistent and up-to-date availability across platforms, saving you time and effort in managing multiple calendars.

## Dependencies

This project has been developed using the following key dependencies:

- **Ruby**: Version 2.7.5
- **Rails**: Version 7.0.4
- **Bootstrap**: Version 5.1
- **Rspec**
- **Rubocop**
- **Sass**
- **Payify**
- **Stripe**

## Online payment

To use online payment for bookings, you need to have a Stripe account.

You can set your Stripe API credentials and define currency using environment variables. (Secret key, Publishable key)

```ruby
# .env
STRIPE_API_KEY="..."
STRIPE_PUBLISHABLE_KEY="..."
```

![Screenshot](./app/assets/images/screenshot-payment.png)

## Translations

By default two languages are available, a language selector in the footer allows you to change the interface language.

- French 🇫🇷
- English 🇺🇸

## Installation

To launch the application, follow these steps:

1. Run `bundle install`
2. Run `rails db:create`
3. Run `rails db:migrate`
4. Run `rails db:seed`
6. Run `rails s`

Then, open your browser and navigate to http://localhost:3000 to access the application.

## Tests

To run the tests, execute `rspec` command.
