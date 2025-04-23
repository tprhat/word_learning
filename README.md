# Word Learn

This is a Ruby on Rails web application for learning words through interactive games. 
The game can be played both anonymously or logged in, while logged in the game records your stats to the database which you can check out in the "My stats" page.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- [Ruby on Rails](https://rubyonrails.org) 

## Cloning the Repository

It is recommended to fork the repository first so you can make changes if needed and then clone the repository:

```sh
git clone https://github.com/tprhat/word_learning.git
cd word_learning
```

## Setup and Installation

1. **Install Gems**

   Install the required gems using Bundler:

   ```sh
   bundle install
   ```

2. **Setup the Database**

   Create and initialize the database:

   ```sh
   bin/rails db:create
   bin/rails db:migrate
   ```

   Import the word data from the csv
   ```sh
   bin/rails db:import_dict
   ```

## Running the Application

Start the Rails server:

```sh
bin/rails server
```

Now open your browser and navigate to [http://localhost:3000](http://localhost:3000).


## Additional Configuration

Check the following files for additional configuration details:

- `.ruby-version` – specifies the Ruby version
- `Gemfile` – lists gem dependencies
- `config/environments/` – environment-specific settings


## License

[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)