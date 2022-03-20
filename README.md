# Topshelf

Topshelf is a basic inventrory management system for your home bar.

Have you ever thought to yourself: "Making cocktails for a whole dinner party is not complicated enough, I would like some technology to make this more exciting. How much Rum do I have anyway?"?

Topshelf keeps a list of liquor bottles, their locations, and how much is left in them. You no longer need to interupt your partner while they regale your dinner guests to ask if there is any tequila left.

## Deployment

Deloyment goals of Topshelf are to be easily deployed to fly.io or to a Raspberry Pi on your local network.

## Coming Features

- *Deployment instructions*. Deploying this to run yourself should be really easy. Instructions on how to do that are essential.
- *Cocktail Recipies*. A list of coctail recipies with a list of bottles to pull out and from where.
- *Shopping List*. A list that has all of the bottles that are low or empty. Differentiate between bottles that a staples and one offs.
- *Make cocktail button*. Reduce a bottles remaining volume by the amount a recipie calls for when a cocktail is made.
- *Empty bottle button*. Mark a bottle as completely used with a single button.
- *New bottle button*. Mark a brand new bottle as bought with a single button click.
- *Empty bottle display*. Show which bottles are empty in the lists. Show which coctails cannot be made because bottles are empty.
- *Guest View*. A view for guests to see cocktail options.
- *Guest Ordering*. A way for guests to queue up cocktail orders.

## Bugs

- Migrations are not run automtically. Migrations on fly.io and Sqlite seem to have a conflict. Might move back to postgres as the decision to use Sqlite is questionable. For now, migrations can be run with `fly shh console` > `/app/bin/migrate`

## Questionable decisions

- *Sqlite*. This can make deploying to a Rspberry Pi easy as it requires no other services running. Might be better to just create a docker-compose with postgres.

- *Schemaless Changeset*. Using a changeset for search functionality might be a good idea for more complicated searches. We will see if this gets that far. Likely the changeset should be refactored to something better than just `Search`. Also, where should this changeset live?

- *Petal Components*. The approach here to styling is not something I am perfectly comfortable with. Tailwind is the direction that the Elixir comunity is heading, so it seems like it is a bad decision to fight that. However, patterns established by Tailwind are far from DRY and are very questionable themselves. A stable of basic components addresses makes the code DRY, but adds its own complexities. For this project I decided that going with basic components was better than the anti-patterns that Tailwind suggests. Petal Compnents speeds this process up significantly.

- *Writing this app*. This is an entire app to manage a handful of liquor bottles. This is really overkill. But it is also really fun.
