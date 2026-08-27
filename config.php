<?php
// Konfigurasi database SIAKAD ITAF
// Untuk XAMPP: DB_HOST=127.0.0.1, DB_NAME=siakad_itaf, DB_USER=root, DB_PASS=''
const DB_HOST = '127.0.0.1';
const DB_NAME = 'siakad_itaf';
const DB_USER = 'root';
const DB_PASS = '';
const APP_NAME = 'SIAKAD ITAF';
const INSTITUTION = 'INSTITUT TEKNOLOGI ALBERTH FOENAY';
const MAX_SKS = 24;

function db(): PDO {
    static $pdo;
    if (!$pdo) {
        $pdo = new PDO('mysql:host='.DB_HOST.';dbname='.DB_NAME.';charset=utf8mb4', DB_USER, DB_PASS, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]);
    }
    return $pdo;
}
function json_response($data, int $status=200): never {
    http_response_code($status); header('Content-Type: application/json; charset=utf-8'); echo json_encode($data, JSON_UNESCAPED_UNICODE); exit;
}
function require_login(): array {
    if (empty($_SESSION['user'])) json_response(['ok'=>false,'message'=>'Sesi login berakhir.'],401);
    return $_SESSION['user'];
}
function require_admin(): array {
    $u=require_login(); if (($u['role']??'')!=='admin') json_response(['ok'=>false,'message'=>'Akses admin ditolak.'],403); return $u;
}
function clean($v): string { return trim((string)($v ?? '')); }
function esc($v): string { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
