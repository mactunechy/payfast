# Payfast

Payfast is a Ruby gem that simplifies the process of integrating the PayFast payment gateway into your Ruby on Rails application. It provides a generator that helps scaffold the necessary configuration, routes, models, and controllers required to integrate PayFast seamlessly.

## Installation

Add this line to your application's Gemfile:

```bash
    bundle add payfast
```
Or install it yourseld as:


```bash
    gem install payfast
```

## Usage

```bash
  rails generate payfast:install
```

## This generator will perform the following actions:

    insert  config/routes.rb
    create  app/controllers/carts_controller.rb
    create  app/views/carts/index.html.erb
    create  app/views/carts/make_payment.html.erb
    create  app/helpers/carts_helper.rb
    create  db/migrate/20230824105530_create_carts.rb
    create  config/payfast.yml
    create  app/models/cart.rb
    insert  app/views/layouts/application.html.erb
    insert  config/environments/development.rb



## Additional configuration

Setup payfast credentials for your environment

    rails EDITOR="code --wait" bin/rails credentials:edit
  
  This will allow you to securely edit and store your credentials. once you save and exit the file, the credentials will be encrypted and can only be accessed withe rails master key.

    payfast: 
      merchant_id: {your_merchant_id}
      merchant_key: {your_merchant_key}
      passphrase:  {{your_passphrase}}

## Update your `payfast.yml` config file
- setup the credentials to be use by the rails app
- uncomment `Rails.application.credentials.payfast.merchant_id ` and wrap it in erb tags as instructed in the comments.


## Templates
 Update the `make_payment.html.erb` as instructed in the file. it should look like so:

```js
<script>
// set the uuid to  uuid = @cart.payment_uid. surround @carts.payment_uid with erb tags
const uuid = `<%= @cart.payment_uuid %>`
window.payfast_do_onsite_payment({uuid}, function (result) {
  if (result === true) {
    // redirect success_path(@cart)
    window.location.href = `<%= success_cart_path(@cart) %>`
  }
  else {
    // Redirect to  failure_path(@cart)
    window.location.href = `<%= failure_cart_path(@cart) %>`
  }
});
</script>
```

## Testing
- payfast api allows only SSL communication from your server. inorder to test locally. you will have to use a tunneling service that allows you to expose your local development server to the internet. 

your rails development config has was modified by the generator to allow ngrok hosts to hit your rails server

```ruby
 config.hosts << /[a-z0-9-]+\.ngrok-free\.app/
```







## Contributing

Thank you for considering contributing to our project! We welcome contributions from the community to help improve this project and make it better for everyone.

### Issues

If you encounter any issues or bugs while using our project, please [open a new issue](https://github.com/mactunechy/payfast/issues) on GitHub. Please make sure to include detailed information about the problem, steps to reproduce it, and the environment in which you encountered it.

### Pull Requests

We encourage pull requests from the community! If you have an improvement or new feature you'd like to contribute, please follow these steps:

1. Fork the repository and create a new branch for your feature or bug fix.
2. Make your changes and write tests to cover any new functionality.
3. Ensure that the existing tests pass and write additional tests for any bug fixes.
4. Commit your changes and push the new branch to your forked repository.
5. Submit a pull request to our main repository, including a detailed description of the changes you made and any relevant information.

We will review your pull request as soon as possible and provide feedback if needed. We value your contributions and will work with you to ensure your changes are integrated smoothly.
d

Your contributions are essential to the success of this project, and we are grateful for your help in making it better for everyone. If you have any questions or need further assistance, feel free to reach out to us.

Happy coding!















