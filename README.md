# HC.sh

A simple solution to get a device's IP address sent to a webhook on boot.

## Overview

This project provides a script and a systemd service that work together to send a device's public and private IP addresses to a private webhook when the device boots up and connects to a network.

For example, this would be particularly useful for headless devices like a Raspberry Pi on a DHCP network, where the IP address might change on each boot.

## How It Works

1.  The `hc.service` systemd unit is configured to run after the network is online.
2.  Once the network is available, the service executes the `hc.sh` script.
3.  The script fetches the device's public and private IP addresses.
4.  It then sends these IP addresses to a webhook.

## Prerequisites

- `curl`
- A webhook URL. As an example I will be using Discord. You can find instructions on how to create one [here](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks).

## Setup

1.  **Install the Service**

    Run the following command to install the script and service file:

    ```bash
    sudo make install
    ```

2.  **Configure the Webhook**

    Open the installed script file and replace the empty value within `WEBHOOK` variable with your actual webhook URL.

    ```bash
    sudo nano /usr/local/bin/hc.sh
    ```

    ```bash
    #!/bin/bash

    WEBHOOK="YOUR_DISCORD_WEBHOOK_URL_HERE"
    # ... rest of the script
    ```

3.  **Enable the Service**

    Finally, enable the service to start on boot.

    ```bash
    sudo make enable
    ```

## Usage

The service will now run automatically every time the system boots up and establishes a network connection. You should see a message on your Discord channel with the IP addresses of your device.

To test the script manually, you can run it from your terminal:

```bash
/usr/local/bin/hc.sh
```

## Uninstallation

To remove the service and script:

```bash
sudo make uninstall
```
