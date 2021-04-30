#!/bin/bash
./easyrsa --batch init-pki
./easyrsa --batch build-ca nopass
./easyrsa --batch gen-req traefik nopass
./easyrsa --batch sign-req server traefik


