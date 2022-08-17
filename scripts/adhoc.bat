podman build -f .\src\Containerfile -t demo

podman run -p 9000:80 --name demo --replace --rm -d localhost/demo:latest

podman run -p 9000:80 --name demo --replace --rm -d -v src/nginx.conf:/etc/nginx/nginx.conf -v src/www:/var/www/site -v src/access.log:/var/log/nginx/access.log -v src/error.log:/var/log/nginx/error.log localhost/demo:latest

podman exec -it 0c6e9a7fead755a5b0c349a1444357e09278e9164f2bc61b39e4f651c47e0b98 /var/log/nginx

podman run -p 9000:443 --name demo --replace --rm -d -v resources:/var/app localhost/demo:latest

podman run -p 9000:443 --name demo --replace --rm -d -v src/nginx.conf:/etc/nginx/nginx.conf -v src/www:/var/www/site -v resources:/var/app -v src/access.log:/var/log/nginx/access.log -v src/error.log:/var/log/nginx/error.log localhost/demo:latest
