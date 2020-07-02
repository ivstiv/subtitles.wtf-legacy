<?php
require '../../src/api/vendor/autoload.php';

if(isset($_GET['query'])) {
    echo proxyRequest($_GET['query']);
}

function proxyRequest($query) {
    $headers = ['X-User-Agent' => 'TemporaryUserAgent'];
    $client = new GuzzleHttp\Client(['base_uri' => 'https://rest.opensubtitles.org/search/']);
    $request = new GuzzleHttp\Psr7\Request('GET', $query, $headers);
    $response = $client->send($request, ['timeout' => 2]);
    return $response->getBody();
}
