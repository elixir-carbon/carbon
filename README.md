# Carbon

User library for phoenix and elixir.


![Carbon](https://raw.githubusercontent.com/elixirdrops/carbon/master/carbon.png)


## Installation

Carbon is [available in Hex](https://hex.pm/packages/carbon), and can be installed as:

  1. Add `carbon` to your list of dependencies in `mix.exs`:

        def deps do
          [{:carbon, "~> 0.1.3"}]
        end

  2. Ensure `carbon` is started before your application:

        def application do
          [applications: [:carbon]]
        end


## Usage

To install carbon in your application 

      mix carbon.install

  Above command generates a migration, that is all you need to install
  Carbon, you can modify the migration to add your custom fields, 
  Carbon only requires following fields

      * email
      * password_hash
      * password_reset_token

  To install and migrate database use --migrate switch

      mix carbon.install --migrate

  configure Carbon

      config :carbon, 
        repo: MyApp.Repo

  Setup a mailer to send out emails, Carbon uses swoosh email library to send out 
  emails, please visit (Swoosh)[https://github.com/swoosh/swoosh] for more details
  
      config :carbon, Carbon.Mailer,
        adapter: Swoosh.Adapters.Logger,
        level: :debug

  Register Carbon routes in your web/router.ex

      use Carbon.Routes

  Carbon registers few routes, and can be overridden

      /login
      /logout
      /register
      /password/reset


## Roadmap

We are using carbon in production already, we have big plans for Carbon, 
here is a short list of the stuff in pipeline:

- [x] mailers for welcome,signup,reset emails
- [ ] generators for migration, controllers, views, models, mailers
- [ ] oauth integration
- [ ] multiple adapter support session,jwt and more
- [ ] and perhaps memberships out of the box

## Contributing

Contributions are welcome! We love you if you send a PR with some tests.

## License

Copyright (c) 2016, al-razi.

Apache 2 License.
