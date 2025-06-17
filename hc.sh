#!/bin/bash

WEBHOOK=""

PUBLIC_IP=$(curl -s ifconfig.me/ip)
if [[ $? -ne 0 || -z "$PUBLIC_IP" ]]; then
  echo "Failed to get public IP"
  exit 1
fi

PRIVATE_IP=$(hostname -I | awk '{print $1}')
if [[ $? -ne 0 || -z "$PRIVATE_IP" ]]; then
  echo "Failed to get private IP"
  exit 1
fi

if [[ -z "$PUBLIC_IP" || -z "$PRIVATE_IP" ]]; then
  echo "Public or private IP is empty"
  exit 1
fi

curl -H "Content-Type: application/json" \
  -X POST \
  -d '{"content": "I am connected!\nMy public IP is: `'"$PUBLIC_IP"'`\nMy private IP: `'"$PRIVATE_IP"'`\nBye bye!"}' \
  "$WEBHOOK"

if [[ $? -ne 0 ]]; then
  echo "Failed to send webhook"
  exit 1
fi