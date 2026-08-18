<?php

declare(strict_types=1);

$path = parse_url((string) ($_SERVER['REQUEST_URI'] ?? '/'), PHP_URL_PATH) ?: '/';
$file = __DIR__ . $path;

if ($path === '/') {
    require __DIR__ . '/index.php';
    return true;
}

if (is_file($file)) {
    return false;
}

if (is_dir($file) && is_file($file . '/index.php')) {
    require $file . '/index.php';
    return true;
}

if ($path === '/health' || $path === '/ready' || $path === '/api/v1' || str_starts_with($path, '/api/v1/')) {
    require __DIR__ . '/api/v1/index.php';
    return true;
}

http_response_code(404);
header('Content-Type: text/plain; charset=UTF-8');
echo 'Not found.';
return true;
