# hubot-lyt

Slack-bot laget med [HuBot](http://hubot.github.com), brukt til å
teste og sette i drift nye versjoner av [LYT](https://github.com/Notalib/LYT).

## Sette opp LYT test-server

Test-server må kjøre Ubuntu. Her antas Ubuntu 15.10.

## 1. Installér [nodejs](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)

```
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm
```

## 2. Installér avhengigheter for å kompilere LYT

```
sudo npm install -g coffee-script
sudo apt-get install ruby
sudo gem update --system && sudo gem install compass
```

## 3. Installér git

```
sudo apt-get install git
```

## 4. Sørg for at lytbot starter ved boot

Skriv `crontab -e` og legg til denne linjen:

```
@reboot while true; do cd $HOME/lytbot && bin/hubot > $HOME/lytbot.log ; done
```

## 5. Konfigurér Slack

Lag filen ~/config/hubot-slack.token og legg til den Slack token som skal brukes som første linje.
F.eks. `xoxb-***-***`.

Lag filen ~/config/slack.webhook og legg den Slack-webhook-URLen du vil bruke dit som første linje.
F.eks. `https://hooks.slack.com/services/***`.

## 6. Installér Apache web-server

```
sudo apt-get install apache2
sudo rm /var/www/html -rf
sudo ln --symbolic $HOME/hubot-lyt/target/www /var/www/test
```
