<?php

require_once __DIR__ . "/../vendor/autoload.php";
require_once __DIR__ . "/../config/jwt.php";
require_once __DIR__ . "/../modelo/Banco.php";

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

function authMiddleware(array $papeisPermitidos = []) {
    $headers = getallheaders();

    if (!isset($headers['Authorization'])) {
        http_response_code(401);
        echo json_encode(["erro" => "Token não informado"]);
        exit;
    }

    $token = str_replace("Bearer ", "", $headers['Authorization']);

    try {
        $decoded = JWT::decode($token, new Key(JWT_SECRET, 'HS256'));

        // validar usuário no banco
        $banco = new Banco();
        $con = $banco->getConexao();

        $stmt = $con->prepare("
            SELECT u.id, u.ativo, p.nome AS papel
            FROM usuarios u
            JOIN usuarios_papeis up ON up.usuario_id = u.id
            JOIN papeis p ON p.id = up.papel_id
            WHERE u.id = ?
        ");
        $stmt->bind_param("i", $decoded->sub);
        $stmt->execute();
        $user = $stmt->get_result()->fetch_assoc();

        if (!$user || !$user['ativo']) {
            http_response_code(401);
            echo json_encode(["erro" => "Usuário inválido"]);
            exit;
        }

        // valida papel
        if (!empty($papeisPermitidos) && !in_array($user['papel'], $papeisPermitidos)) {
            http_response_code(403);
            echo json_encode(["erro" => "Acesso negado"]);
            exit;
        }

        return $decoded;

    } catch (Exception $e) {
        http_response_code(401);
        echo json_encode(["erro" => "Token inválido ou expirado"]);
        exit;
    }
}
