# FUNDUS FRONTEND

> Version: 1.0.0

## Introduction

This is the frontend of the Fundus project. It is a web application that allows users to upload images of their fundus and get a diagnosis of their condition. The frontend is built using Ruby on Rails, Native CSS, and StimulusJS from [Hotwire](https://hotwire.dev/) framework.

## Deployment
### Requirements (on Server)
- Rbenv
- Ruby 3.1.3
- NodeJS (min. v18) installed with NVM
- MongoDB authenticated with SCRAM
- Redis
- Nginx
- Passenger (Nginx module)

### Steps
#### Redis
```bash
# Add Redis PPA and install
sudo add-apt-repository ppa:chris-lea/redis-server
sudo apt-get update && sudo apt install -y redis-server
```

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