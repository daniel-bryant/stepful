# a Coaching Conundrum

## Assignment

https://you.ashbyhq.com/Stepful/assignment/f12209fe-df65-45cc-b306-e27a5433d24b

I completed features 1- 4. Coaches and students can create and book slots.
Toggle between the two by clicking a button in the top right of the screen.

## Running

### Dependencies

- PostgreSQL
- Node.js

### Backend

Starting from the root directory:

```
cd stepful-api
bundle install
bin/rails db:reset
bin/rails s
```

The server should be running at http://localhost:3000.

### Frontend

In another window/tab, back in the root directory:

```
cd stepful-ui
npm install
npm run dev
```

The website should be available at http://localhost:5173.

### Data

`rails db:reset` should have seeded the database with some sample data. You can
see the code at `stepful-api/db/seeds.rb` or even add more an reset again. Coach
and student IDs are hardcoded in. See: `stepful-ui/app/components/CoachView.tsx`
and `stepful-ui/app/components/StudentView.tsx`.
