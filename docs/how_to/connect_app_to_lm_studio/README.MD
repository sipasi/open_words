## Connect App to LM Studio

Once your model is running on LM Studio, you can connect Open Words app using the network address.

#### 1. Ensure your model is running and served on the local network ([see previous step](../setup_lm_studio/README.MD)).
#### 2. Copy the **“Reachable at”** address from LM Studio (usually looks like `http://192.168.x.x:1234`).

<img src="../setup_lm_studio/assets/pc-step-3-serve-on-local-network.png?raw=true" />

#### 3. Open app (example: Android app).

- Select **Ai Provider** for the template creator
- Tap to **Create** button at the bottom-right

<img src="assets/step-1-open-settings.JPG?raw=true" width="30%"/>
<img src="assets/step-2-open-ai-templater.jpg?raw=true" width="30%"/>

#### 4. Create First Template
  - Select **LAN** for Connection
    - At the moment, only **LAN** connection works
  - Paste the `Reacheble at` address from Step 2 into URL ([Step 2](#2-copy-the-reachable-at-address-from-lm-studio-usually-looks-like-http192168xx1234))
  - Select or enter the Model name
    - If the server is running and the model is downloaded, it should appear in the list

<img src="assets/step-3-select-connection.jpg?raw=true" width="30%"/>
<img src="assets/step-4-enter-address.jpg?raw=true" width="30%"/>
<img src="assets/step-5-select-model.jpg?raw=true" width="30%"/>
 
#### 5. Try Add words
  - Type a word in the Origin Language input field
  - Tap **With AI**
    - If your PC is low-spec or the model hasn’t loaded yet, a loading indicator appears
    - Once done, the translated word appears in the Translation Language field

<img src="assets/step-6-add-words-loading.jpg?raw=true" width="30%"/>
<img src="assets/step-7-add-words-complete.jpg?raw=true" width="30%"/>
