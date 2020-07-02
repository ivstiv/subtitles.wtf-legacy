# subtitles.wtf
Where To Find Subtitles? Hence, the domain.. :D Honestly, I made this Vue app just because I thought it would be e a cool acronym for its purpose! Glad that I found the [OMDb API](https://www.omdbapi.com) as well as the [Open Subtitles API](https://www.opensubtitles.org/) to save me a lot of headaches and reduced my back-end to 2 short php files.

## Deployment
If you want to deploy it on a VPS with NGINX just run:
```
sh deploy.sh
```
This will install all depenedencies, build the project, install the backend and tell you where the .env file is. You just need to adjust your server block according to [this](https://github.com/Ivstiv/subtitles.wtf/blob/master/nginx_serverblock.conf) example.
Then run the following command to reload the configuration:
```
nginx -t && nginx -s reload
``` 

If you however want this to run on a shared hosting it will require you to do everything from the script manually. You can easily just copy the commands from the script so I will list the general steps you need to take rather than just laying out commands that might not be useful in a more general setting. 
```
1. Install the NPM dependencies
2. Build the project which will be generated in the /dist folder
3. Run composer install in ./src/api to install the back-end dependencies (dotenv and guzzle)
4. Move the 2 php files from ./src/api to a new folder in ./dist/api where the rest of the project is
5. Make sure to ship the ./src/api/vendor folder with the ./dist but adjust the relative paths in movies.php and subtitles.php to correctly resolve the .env file and the vendor folder.
6. Edit your .env file with an API key and User Agent. 
7. Make sure that your vendor folder and .env file are not publicly available!
```

## Project setup (for development)
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

### Backend setup
The way I am doing it is to use the public web server of subtitles.wtf with [CORS Unblock](https://addons.mozilla.org/en-US/firefox/addon/cors-unblock/) which seems to be available for most browsers. In this way I get a locally hosted web app which just sends AJAX requests to the public server. It is a dirty approach but I really didn't want to make the whole setup more complicted for back-end of less than 20 lines of code.. Soo, yeah just host it however you want and disable CORS during development. 

## Environmental variables
You will need an [OMDb API](https://www.omdbapi.com) key and an [Open Subtitles API](https://trac.opensubtitles.org/projects/opensubtitles/wiki/DevReadFirst) user agent or just use their development agent "TemporaryUserAgent". However, I would advise you to atleast read their documentation and rules for its usage. 
