<?php

require_once BASE_PATH . "/middleware/AuthMiddleware.php";

$usuario = authMiddleware(); // executa validação do token

echo json_encode([
    "msg" => "Acesso autorizado",
    "usuario_logado" => $usuario
]);
