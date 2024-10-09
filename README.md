
# TeamSpeak 3 Installer

**TeamSpeak 3 Installer** is a simple bash script for automatically installing and configuring a TeamSpeak 3 server on a Linux server with a single command. The script performs the following tasks:

- Updates the system and installs dependencies.
- Downloads the latest available version of the TeamSpeak 3 server from the official site.
- Sets up TeamSpeak as a service to start automatically on boot.
- Displays the administrative token for further server configuration via the TeamSpeak client.

### Quick Installation

To install the TeamSpeak server on your machine, simply run the following command in your terminal:

```bash
bash <(curl -s https://raw.githubusercontent.com/lowdigital/teamspeak3installer/main/ts3installer.sh)
```

## Features

- **Automatic download of the latest version**: The script automatically finds and downloads the latest available version of the TeamSpeak 3 server.
- **Autostart via systemd**: Configures TeamSpeak as a service, allowing it to start automatically when the system boots.
- **Easy installation**: Install and configure the server using a single command.

## Requirements

- A Linux server with SSH access (e.g., VPS or Dedicated server).
- Operating system: Debian 12 (or a compatible version).
- Root privileges are required for installation and configuration.

## Installation

### Step 1: Ensure you have the required tools installed

Before starting, make sure you have the necessary tools to download and run the script:

```bash
apt update && apt install -y curl wget
```

### Step 2: Install TeamSpeak using a single command

To install TeamSpeak with a single command, run the following:

```bash
bash <(curl -s https://raw.githubusercontent.com/lowdigital/teamspeak3installer/main/ts3installer.sh)
```

### Step 3: Connect to the server

1. After the installation is complete, the script will display the **Admin Token**, which will be required when connecting to the server for the first time via the TeamSpeak client.
2. Use your server's IP address and the default port (9987) to connect to TeamSpeak.
3. Enter the Admin Token when prompted to grant administrator rights.

## Usage

Once installed, the TeamSpeak server will automatically start with the system. 

You can manually control the server with the following commands:

- **Start the server**:
  ```bash
  service teamspeak start
  ```

- **Stop the server**:
  ```bash
  service teamspeak stop
  ```

- **Restart the server**:
  ```bash
  service teamspeak restart
  ```

- **Check the server status**:
  ```bash
  service teamspeak status
  ```

## Logs

TeamSpeak server logs can be found in the following directory:

```
/opt/teamspeak/logs/
```

To view the latest log file with the admin token:

```bash
cat /opt/teamspeak/logs/ts3server_*.log
```

## Updating the TeamSpeak Server

When a new version of TeamSpeak is released, you can manually update the server by following these steps:

1. Stop the current TeamSpeak service:
   ```bash
   service teamspeak stop
   ```

2. Download and install the latest version, following the instructions in the script or by updating it.

3. Restart the TeamSpeak service:
   ```bash
   service teamspeak start
   ```

## Uninstalling the TeamSpeak Server

To remove the TeamSpeak server from your system, run the following commands:

```bash
service teamspeak stop
systemctl disable teamspeak
rm -rf /opt/teamspeak
rm /etc/systemd/system/teamspeak.service
systemctl daemon-reload
```

## License

This project is licensed under the MIT License.

## Authors

- Project Author: [low digital](https://t.me/low_digital)
