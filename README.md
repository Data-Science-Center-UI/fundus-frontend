# FUNDUS FRONTEND

> Version: 1.0.0

## Introduction

This is the frontend of the Fundus project. It is a web application that allows users to upload images of their fundus and get a diagnosis of their condition. The frontend is built using Ruby on Rails, Native CSS, and StimulusJS from [Hotwire](https://hotwire.dev/) framework.

## Deployment
### Requirements
- Rbenv
- Ruby 3.1.3
- NodeJS (min. v18) installed with NVM
- MongoDB authenticated with SCRAM
- Redis
- Nginx
- Passenger (Nginx module)

### Steps
All deployment steps requires Ubuntu 22.04 LTS or Higher. For other OS, please search steps on Internet, following steps below:

#### Rbenv and Ruby

```bash
# Install Depedencies
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates curl

# Install Rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
exec $SHELL

# Install Ruby
rbenv install 3.1.3
rbenv global 3.1.3

# Install Bundler
gem install bundler
```

#### NodeJS

```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
exec $SHELL

# Install NodeJS
nvm install --lts

# Check NodeJS version
node -v
```
#### Redis
```bash
# Add Redis PPA and install
sudo add-apt-repository ppa:chris-lea/redis-server
sudo apt-get update && sudo apt install -y redis-server

# Enable and Start Redis Service (Using Systemd)
sudo systemctl enable redis-server && sudo systemctl start redis-server
```

#### MongoDB
```bash
# Install depedencies
sudo apt-get install -y gnupg curl

# Add MongoDB GPG
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

# Create Repository list file
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Update repository data and install MongoDB
sudo apt update && sudo apt-get install -y mongodb-org

# Enable and Start MongoDB Service (Using Systemd)
sudo systemctl enable mongod && sudo systemctl start mongod
```

## Development
### Requirements
For development purpose, please install all depedencies above, excluding Nginx and Passenger.
Clone this repository to your development machine.

Additional depedencies is given below:

```bash
# Install Rails on your machine
gem install rails
```

After rails installed, change your dir to `fundus-frontend`, then runs `bundler`. If any error occurs when bundler initialization, runs `gem update --system`.

After initialization success, change dir to `config`, then create `master.key` file with given value: **`e57071dd1de799346e8d0af190a91f03`**. This master key used to encrypt and decrypt credentials on `credentials.yml.enc`. If you lost this key, value inside credentials file wont be decrypted by system.

To change value on credentials, runs `EDITOR=nano rails credentials:edit`.

To start rails apps, runs `rails s`. Open your browser and go to `http://localhost:3000`

If this is your first init, you must have First Initial User (aka: User Admin) on your db. Open new terminal window, change your dir to `fundus-frontend`, runs `rails console`, then create this user by following code:
```ruby
User.create! email: "your@email.com", password: "Y0uRP4$$word", username: "admin", role: "Admin"
```

Back to your browser then login with this user.

Cheers!
