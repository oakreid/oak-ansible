server {
	server_name twitch.hexdrinkers.com;

	location / {
		proxy_pass http://localhost:42069;
	}

    listen [::]:443 ssl ipv6only=on;
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/twitch.hexdrinkers.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/twitch.hexdrinkers.com/privkey.pem;
}
server {
    if ($host = twitch.hexdrinkers.com) {
        return 301 https://$host$request_uri;
    }

	server_name twitch.hexdrinkers.com;
	
	listen 80;
	listen [::]:80;
    return 404;
}
