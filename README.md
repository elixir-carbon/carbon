# Carbon

User library for phoenix and elixir.


![Carbon](https://raw.githubusercontent.com/elixirdrops/carbon/master/carbon.png)


## Installation

Carbon is [available in Hex](https://hex.pm/packages/carbon), and can be installed as:

  1. Add `carbon` to your list of dependencies in `mix.exs`:

        def deps do
          [{:carbon, "~> 0.1.1"}]
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

  To install and migrate database use --migrate switch

      mix carbon.install --migrate

  configure  Carbon to use repo

      config :carbon, 
        repo: MyApp.Repo

  Register Carbon routes in your web/router.ex

      use Carbon.Routes

  Carbon registers few routes, and can be overridden

      /login
      /logout
      /register
      /password/reset


## Roadmap

We are using carbon in production already, we have plans for 
Carbon some of the stuff in pipeline:

    * generators for migration, controllers, views, models, mailers
    * mailers for welcome,signup,reset emails
    * oauth integration
    * multiple adapter support session,jwt and more
    * and perhaps memberships out of the box

## Contributing

Contributions are welcome! We love you if you send a PR with some tests.

## License

Copyright (c) 2016, al-razi.

Apache 2 License.
