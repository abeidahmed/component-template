# Tailwind component

Hosted on [Tailwind component](https://tailwind-component.herokuapp.com/)

### Disclaimer

This app is not meant to replace or harm [TailwindUI](https://tailwindui.com/) in any way possible. This app is meant to be used for learning purposes only.

### Structure of the app

The data structure of this app is explained below:

- Main wrapper Ex: Page sections (which is listed as ComponentCollection in the db)
- Child wrapper of the templates Ex: Hero sections (which is listed as Category in the db)
- Components within 'Hero sections' (which is listed as Component in the db)

### How to use the app

- Clone this app and run `bundle install`.
- `rails db:create db:migrate db:seed` to get the app rolling to its default state.
- `rails s`.
- `./bin/webpack-dev-server` to start the webpack server.
- Go to `localhost:3000`.

There is no Admin section in this app.

#### Steps

To create the `Main wrapper`, type `rails c` in your terminal and type `ComponentCollection.create! title: 'Headings'`. This will create a `Main wrapper` which will be responsible for storing all the categories related to the tag `Headings`.

Next create the category for `Headings`. Exit out of the `rails c` if you haven't.
`rails g category headings page_headings`.

- This is a custom rails generator and it will create a `page_headings` category inside the `headings` table. Please follow the `rails` naming convention. The generator will take care of the `category` name while storing in the `db`.
- It will also create an empty folder within the `app/components/` folder or the `app/pages` folder. The location depends on the `Main wrapper` which in this case is `headings` and which was created by `ComponentCollection.create! title: 'Headings'`.

Next create the template for `page_headings` category.
`rails g template page_headings with_meta_and_actions --type=component`.

- This is a custom rails generator and it will create a `with_meta_and_actions` template within the `page_headings` category. Again follow the rails naming convention.
- This will create a `html` file within the `page_headings` folder with the name `with_meta_and_actions.html`.
- The `type` args is necessary here. I am thinking of expanding the app by not just making smaller components, but also by making full page templates.

You can visit [TailwindUI](https://tailwindui.com/) to get a brief idea about the structure of the files that you created.

Look at the `components.yml` file in the `db/components.yml`. Using the above generators will ensure proper storage in the `yml` file. But, why the `yml` file? Because the `html` templates are not stored in the `db`. Seeding data in `production` mode will be extremely time consuming and hectic. Hence with the help of the `yml` file, we can just run `heroku run rake db:seed` and the `seeds.rb` will take care of the rest.

### Any errors?

If you face any errors, please open an `issue`. Mostly the errors happen because of name conflict while using generators.
