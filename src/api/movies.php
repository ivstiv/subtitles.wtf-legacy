<?php
require '../../src/api/vendor/autoload.php';

if(isset($_GET['query'])) {
    echo proxyRequest($_GET['query']);
}

function proxyRequest($query) {
    $dotenv = Dotenv\Dotenv::createImmutable('../../src/api');
    $dotenv->load();

    $client = new GuzzleHttp\Client(['base_uri' => 'http://www.omdbapi.com']);
    $request = new GuzzleHttp\Psr7\Request('GET', "?apikey=${$_ENV['OMDB_KEY']}&s=".urlencode($query));
    $response = $client->send($request);
    return $response->getBody();
}