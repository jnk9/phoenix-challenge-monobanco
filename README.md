# Monobanco

# Create Transaction

**URL** : `/api/transactions`

**Method** : `POST`

**Permissions required** : None


Provide name of Account to be created.

```json
{
"transaction":
 {
    "amount": Integer,
    "category": String,
    "description": String,
    "is_deposit": Boolean
  }
}
```

**Data example** All fields must be sent.

```json
{
"transaction": {
  "amount": 10000,
  "category":"category",
  "description":"description",
  "is_deposit":true
  }
}
```

## Success Response

**Condition** : If everything is OK and an Account didn't exist for this User.

**Code** : `201 CREATED`

**Content example**

```json
{
  "data":{
    "id":1,
    "amount": 10000,
    "category":"category",
    "description":"description",
    "is_deposit":true
  }
}
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
