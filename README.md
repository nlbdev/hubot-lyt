# hubot-lyt

hubot-lyt er en chatops bot basert på [Hubot][hubot] for å teste og installere nye
versjoner av [LYT](Notalib/LYT) hos NLB.

hubot-lyt installeres på en intern test-server. hubot-lyt merger siste versjon
fra Notalib/LYT inn i nlbdev/LYT, gjør klar for testing på test-server,
og når den får klarsignal manuelt via chat så kopierer den test-versjonen
over på driftserveren.

## Installasjon

Vi tar utgangspunkt i en fersk Ubuntu 15.10-installasjon.

### 1. Installér [nodejs](https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)

```
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm
```

### 2. Installér avhengigheter for å kompilere LYT

```
sudo npm install -g coffee-script
sudo apt-get install ruby
sudo gem update --system && sudo gem install compass
```

### 3. Installér git

```
sudo apt-get install git
```

### 4. Sørg for at hubot-lyt starter ved boot

Skriv `crontab -e` og legg til denne linjen:

```
@reboot while true; do cd $HOME/hubot-lyt && bin/hubot > $HOME/hubot-lyt.log ; done
```

### 5. Konfigurér Slack

Lag filen ~/config/hubot-slack.token og legg til den Slack token som skal brukes som første linje.
F.eks. `xoxb-***-***`.
Dette er for å koble bot'en til Slack sånn at den kan både sende og motta meldinger.

Lag filen ~/config/slack.webhook og legg den Slack-webhook-URLen du vil bruke dit som første linje.
F.eks. `https://hooks.slack.com/services/***`.
Dette er for at bash-skriptene skal kunne sende meldinger til Slack.

### 6. Installér Apache web-server

```
sudo apt-get install apache2
sudo rm /var/www/html -rf
sudo ln --symbolic $HOME/hubot-lyt/target/www /var/www/test
```

### 7. Konfigurér SSH og IP-adresser

TODO

