# hubot-lyt

hubot-lyt er en chatops bot basert på [Hubot][hubot] for å teste og installere nye
versjoner av [LYT](Notalib/LYT) hos NLB.

hubot-lyt installeres på en intern test-server. hubot-lyt merger siste versjon
fra Notalib/LYT inn i nlbdev/LYT, gjør klar for testing på test-server,
og når den får klarsignal manuelt via chat så kopierer den test-versjonen
over på drift-serveren.

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
git config --global user.name "NLB Bot"
git config --global user.email "jostein@nlb.no"
git config --global github.user nlbbot
git config --global github.token [token]
```

**Merk**: Vi bruker github-brukeren "nlbbot" for å utføre automatiske operasjoner.
Denne brukeren er knyttet til e-posten `jostein@nlb.no` inntil videre, men
i fremtiden bør vi lage en egen e-post for dette; f.eks. `github@nlb.no`.

Erstatt `[token]` med en [GitHub Personal access token](https://github.com/settings/tokens).
Gjenbruk enten den som er installert på serveren allerede, eller lag en ny en hvis
ikke den eksisterende er å oppdrive noe sted.

### 4. Sørg for at hubot-lyt starter ved boot

Skriv `crontab -e` og legg til denne linjen:

```
@reboot while true; do cd $HOME/hubot-lyt && bin/hubot > $HOME/hubot-lyt.log ; done
```

### 5. Konfigurér Slack

Lag filen `~/.config/hubot-lyt/hubot-slack.token` og legg til den Slack token som skal brukes som første linje.
F.eks. `xoxb-***-***`.
Dette er for å koble bot'en til Slack sånn at den kan både sende og motta meldinger.

Lag filen `~/.config/hubot-lyt/slack.webhook` og legg den Slack-webhook-URLen du vil bruke dit som første linje.
F.eks. `https://hooks.slack.com/services/***`.
Dette er for at bash-skriptene skal kunne sende meldinger til Slack.

### 6. Installér Apache web-server

#### På test-server:

```
sudo apt-get install apache2
sudo rm /var/www/html -rf
sudo ln --symbolic $HOME/hubot-lyt/target/www /var/www/html
```

#### På drift-serveren:

```
sudo apt-get install apache2
sudo rm /var/www/html -rf
sudo mkdir /var/www/html
sudo chown -R lyt:lyt html
```

Erstatt "lyt:lyt" med brukernavn og brukergruppe for drift-serveren.

### 7. Konfigurér SSH og IP-adresser

På test-serveren, kjør:

```
ssh-keygen -t rsa
ssh lyt@203.0.113.19 mkdir -p .ssh
cat ~/.ssh/id_rsa.pub | ssh lyt@203.0.113.19 'cat >> .ssh/authorized_keys'
```

Erstatt "lyt" og "203.0.113.19" med brukernavn og IP/hostname for drift-serveren.

Når du kjører `ssh-keygen -t rsa`; bruk standardplassering for lagring av nøkkelen som blir generert.
Ikke fyll inn en passphrase.

Lag filen `~/.config/hubot-lyt/production.config` og fyll den med følgende:

```
user: lyt
ip: 203.0.113.19
path: /var/www/html
```

Erstatt "lyt" og "203.0.113.19" med brukernavn og IP/hostname for drift-serveren.
Hvis stien til web-serveren på drift-serveren er noe annet enn `/var/www/html`
(standard for Apache), så må den også endres.
