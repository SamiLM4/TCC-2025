<?php

require_once __DIR__ . "/../../modelo/Banco.php";
require_once __DIR__ . "/../../config/jwt.php";

use Firebase\JWT\JWT;

$input = json_decode(file_get_contents("php://input"), true);

if (!isset($input['email'], $input['senha'])) {
    http_response_code(400);
    echo json_encode(["erro" => "Email e senha são obrigatórios"]);
    exit;
}

$banco = new Banco();
$con = $banco->getConexao();

$stmt = $con->prepare("
    SELECT u.id, u.email, u.senha_hash, p.nome AS papel
    FROM usuarios u
    JOIN usuarios_papeis up ON up.usuario_id = u.id
    JOIN papeis p ON p.id = up.papel_id
    WHERE u.email = ? AND u.ativo = 1
");

$stmt->bind_param("s", $input['email']);
$stmt->execute();
$result = $stmt->get_result();


if ($usuario = $result->fetch_assoc()) {

    if (!password_verify($input['senha'], $usuario['senha_hash'])) {
        http_response_code(401);
        echo json_encode(["erro" => "Credenciais inválidas"]);
        exit;
    }
    
    
    $payload = [
        "iss" => "tcc25",
        "sub" => $usuario['id'],
        "email" => $usuario['email'],
        "papel" => $usuario['papel'],
        "iat" => time(),
        "exp" => time() + (60 * 60) // 1h
    ];

    $token = JWT::encode($payload, JWT_SECRET, 'HS256');

    echo json_encode([
        "token" => $token
    ]);
    exit;
}

http_response_code(401);
echo json_encode(["erro" => "Usuário não encontrado"]);
