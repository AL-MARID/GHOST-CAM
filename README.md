<p align="center">
  <img 
    src="GHOST-CAM..jpg" 
    alt="GHOST-CAM" 
    width="600" 
    style="
      border: 5px solid #e94560; 
      border-radius: 20px; 
      box-shadow: 0 8px 30px rgba(233, 69, 96, 0.8);
      transition: transform 0.3s ease;
    " 
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
