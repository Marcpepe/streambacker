# Project Streambacker

## Develop with Docker

### Local

`dkm create -d virtualbox streambacker-dev`
`eval $(docker-machine env streambacker-dev)`
`dkc up -d`

### Remote

## Docker Machine

`dkm create -d virtualbox streambacker-dev`
`dkm create -d generic --generic-ip-address 149.202.54.200 --generic-ssh-user root --generic-ssh-key ~/.ssh/stbk_rsa streambacker-staging`

## Setup tests

#### Unit tests

Required :
- Karma (test runner d'Angular)
- Mocha (framework de test)


#### Functional tests

Required :
- Selenium driver (browser launcher: simule utilisateur) (`node_modules/.bin/webdriver-manager update` to install driver, and Java is also needed `sudo apt-get install default-jdk`)
- Protractor (test runner: wrapper of Selenium)
- Cucumber (framework de test)

