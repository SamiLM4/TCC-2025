<?php
require_once "modelo/adm/administrador.php";
require_once "modelo/MeuTokenJWT.php";

use Firebase\JWT\MeuTokenJWT;

// Captura os dados JSON
$input = file_get_contents("php://input");
$dados = json_decode($input);

// VALIDAÇÕES

// Verifica se o JSON é válido
if (json_last_error() !== JSON_ERROR_NONE) {
    http_response_code(400);
    echo json_encode(["status" => false, "msg" => "JSON inválido."]);
    exit();
}

// Verifica se os campos obrigatórios existem
if (!isset($dados->nome, $dados->email, $dados->senha)) {
    http_response_code(400);
    echo json_encode(["status" => false, "msg" => "Campos obrigatórios ausentes (nome, email, senha)."]);
    exit();
}

$nome = trim($dados->nome);

// Valida o email
$email = trim($dados->email);
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(["status" => false, "msg" => "Email inválido."]);
    exit();
}

// Valida a senha (mínimo 6 caracteres)
$senha = $dados->senha;
if (strlen($senha) < 6) {
    http_response_code(400);
    echo json_encode(["status" => false, "msg" => "A senha deve ter no mínimo 6 caracteres."]);
    exit();
}

//

// Instancia o objeto Adm
$adm = new Adm();
$adm->setnome($nome);
$adm->setemail($email);
$adm->setsenha($senha);

// Verifica o token de autorização
$headers = getallheaders();

if (!isset($headers['Authorization'])) {
    http_response_code(401);
    echo json_encode(["status" => false, "msg" => "Token de autorização ausente."]);
    exit();
}

$autorization = $headers['Authorization'];
$meutoken = new MeuTokenJWT();

if (!$meutoken->validarToken($autorization)) {
    http_response_code(401);
    echo json_encode(["status" => false, "msg" => "Token inválido ou expirado."]);
    exit();
}

$payloadRecuperado = $meutoken->getPayload();

if (!isset($payloadRecuperado->papel) || $payloadRecuperado->papel !== "adm") {
    http_response_code(403);
    echo json_encode([
        "cod" => 403,
        "msg" => "Acesso negado. Apenas administradores podem realizar esta operação."
    ]);
    exit();
}

// Tenta cadastrar o administrador
if ($adm->cadastrarAdm()) {
    echo json_encode(["status" => true, "msg" => "Administrador cadastrado com sucesso"]);
} else {
    http_response_code(500);
    echo json_encode(["status" => false, "msg" => "Erro ao cadastrar administrador"]);
}
?>
