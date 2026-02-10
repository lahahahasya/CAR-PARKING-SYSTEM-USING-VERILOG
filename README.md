# Multi-Car Parking System using Verilog (FPGA)
## Overview

This project implements a Multi-Car Parking Management System using Verilog HDL on an FPGA (Artix-7).
The system automatically controls vehicle entry and exit, verifies user credentials, and tracks available parking slots using a Finite State Machine (FSM).

It reduces manual work and helps efficiently manage parking spaces.

## Features

FSM-based parking control logic

Username & password verification for entry

Real-time tracking of available parking slots

Entry/Exit detection using sensors

Full parking indication (STOP state)

7-segment display for slot count

LED indicators (Green = Allowed, Red = Denied)

Designed and simulated in Xilinx Vivado

## System States (FSM)

IDLE – Waiting for a car

WAIT_PASSWORD – User enters credentials

RIGHT_PASS – Correct password → Entry allowed

WRONG_PASS – Incorrect password → Retry

STOP – Parking full / wait
