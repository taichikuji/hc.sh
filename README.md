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

1.  **Configure the Webhook and Service**

    Open the `hc.sh` file and replace the empty value within `WEBHOOK` variable with your actual webhook URL.

    ```bash
    #!/bin/bash

    WEBHOOK="YOUR_DISCORD_WEBHOOK_URL_HERE"
    # ... rest of the script
    ```

    Additionally make sure to modify `hc.service` to include the absolute path where the `hc.sh` script will be located.

2.  **Make the Script Executable**

    Open a terminal and run the following command to make the script executable:

    ```bash
    chmod +x hc.sh
    ```

3.  **Install the Service**

    Now, you need to move the script and the service file to the appropriate system directories.

    ```bash
    sudo mv hc.sh ~/
    sudo mv hc.service /etc/systemd/system/
    ```

4.  **Enable the Service**

    Finally, reload the systemd daemon to recognize the new service and enable it to start on boot.

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable hc.service
    ```

## Usage

The service will now run automatically every time the system boots up and establishes a network connection. You should see a message on your Discord channel with the IP addresses of your device.

To test the script manually, you can run it from your terminal:

```bash
bash ~/hc.sh
```
