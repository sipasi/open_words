# LM Studio Guide

This guide will walk you through downloading, installing, and using **LM Studio**, installing models, and serving them on your local network.


- [LM Studio Guide](#lm-studio-guide)
  - [Download LM Studio](#download-lm-studio)
  - [Use LM Studio](#use-lm-studio)
      - [1. Select `Power User`](#1-select-power-user)
      - [2. Download Model](#2-download-model)
      - [3. Serve on Local Network](#3-serve-on-local-network)
      - [4. Setup Open Words App](#4-setup-open-words-app)
  - [Notes](#notes)

## Download LM Studio

1. Visit [LM Studio Official Website](https://lmstudio.ai/)
2. Choose your operating system (Windows, macOS, Linux).
3. Click **Download**
4.  **Install**
  
## Use LM Studio

#### 1. Select `Power User`

Open LM Studio and select Power User at the bottom-left.

<img src="assets/pc-step-1-user-type-selection.png?raw=true" />

#### 2. Download Model 
  - Open settings --> Select Model Search
  - Search for gemma
  - Select Gemma 3N-E4B
  - Click Download (in screenshot Use in New Chat)

> ✅ You can download any model available in LM Studio.

<img src="assets/pc-step-2-download-model-steps.png?raw=true" />

#### 3. Serve on Local Network
   - Open Developer Tab
   - Ensure `Status`: Running
   - Check Serve on Local Network
   - Copy the Reachable at (by this address we connect to AI)

<img src="assets/pc-step-3-serve-on-local-network.png?raw=true" />

#### 4. Setup Open Words App

Follow [this tutorial](../connect_app_to_lm_studio/README.MD) to connect your model to Open Words App.

## Notes

* Always use the latest version of LM Studio for stability and security.
* Models can need a lot of storage/memory — [check system requirements](https://lmstudio.ai/docs/app/system-requirements).
* For issues, consult the [LM Studio Documentation](https://lmstudio.ai/docs/app).
