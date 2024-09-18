const { Client, GatewayIntentBits, ActivityType } = require('discord.js');
const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent
    ]
});
const axios = require('axios');

//// Send to Server

const securityToken = "any key";
const fetchPath = "http://127.0.0.1:30120/resourcename/aimbot";

//////

client.on('ready', async () => {
    console.log('Discord bot is ready, logged in as:', client.user.tag);
    client.user.setActivity({ name: 'Hello', type: ActivityType.WATCHING });
});

client.on('messageCreate', async message => {
    if (!message.author.bot || !message.embeds[0]) return;

    let found = false;
    let playername = ""

    if (message.channel.id === '') {
        const receivedEmbed = message.embeds[0];
        receivedEmbed.fields.forEach(field => {
            if (field.name == "Violation" && field.value.includes("Aimbot Detected")) {
                found = true
            } else if (field.name == "License") {
                playername = field.value
            }
        });
    }

    if (found) {
        try {
            const response = await axios.post(fetchPath, {
                playeridentifier: playername,
            }, {
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": securityToken
                }
            });

            if(response.status === 500) {
                console.log("Fehler: " + await res.text());
                return
            } else if(response.status == 401) {
                console.log("Server Fehler!");
                return
            } else if(response.status == 404) {
                console.log("Fehler: " + await res.text());
                return
            } else if (response.status === 200) {
                console.log("AimBot Log - Sended");
                return
            }
        } catch (error) {
            console.error('Fehler beim Senden der Anfrage:', error);
        }
    }
});

client.login("token");