<?php
require_once __DIR__ . '/../Banco.php';

class Mensagem
{
    private $cpf_medico;
    private $mensagem;
    private $origem;

    // Setters
    public function setCpfMedico($cpf_medico)
    {
        $this->cpf_medico = $cpf_medico;
    }

    public function setMensagem($mensagem)
    {
        $this->mensagem = $mensagem;
    }

    public function setOrigem($origem)
    {
        $this->origem = $origem;
    }

    // Getters
    public function getCpfMedico()
    {
        return $this->cpf_medico;
    }

    public function getMensagem()
    {
        return $this->mensagem;
    }

    public function getOrigem()
    {
        return $this->origem;
    }

    // Enviar mensagem (usado por médico)
    public function enviar()
    {
        $meuBanco = new Banco();
        $conn = $meuBanco->getConexao();

        // Verifica conexão
        if ($conn->connect_error) {
            die("Erro de conexão: " . $conn->connect_error);
        }

        $sql = "INSERT INTO mensagens_chat (cpf_medico, mensagem, origem) VALUES (?, ?, ?)";
        $stmt = $conn->prepare($sql);

        if ($stmt) {
            $stmt->bind_param("iss", $this->cpf_medico, $this->mensagem, $this->origem);
            if ($stmt->execute()) {
                return true;
            } else {
                error_log("Erro ao enviar mensagem: " . $stmt->error);
                return false;
            }
        } else {
            error_log("Erro na preparação do envio: " . $conn->error);
            return false;
        }
    }

    // ADM responder mensagem
    public function responder()
    {
        // origem = 'adm' será automaticamente atribuída
        return $this->enviar();
    }

    // Listar mensagens de um médico
    public function listarMensagensMedico($cpf_medico)
    {
        $meuBanco = new Banco();
        $conn = $meuBanco->getConexao();

        $sql = "SELECT * FROM mensagens_chat WHERE cpf_medico = ? ORDER BY data_envio ASC";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $cpf_medico);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $mensagens = [];

            while ($linha = $result->fetch_assoc()) {
                $mensagens[] = $linha;
            }

            return $mensagens;
        } else {
            return false;
        }
    }

    // Listar todas mensagens para o ADM
    public function listarTodas()
    {
        $meuBanco = new Banco();
        $conn = $meuBanco->getConexao();

        $sql = "SELECT m.*, med.nome AS nome_medico 
                FROM mensagens_chat m 
                JOIN medico med ON m.cpf_medico = med.cpf 
                ORDER BY m.data_envio DESC";

        $result = $conn->query($sql);
        $mensagens = [];

        while ($linha = $result->fetch_assoc()) {
            $mensagens[] = $linha;
        }

        return $mensagens;
    }
}
?>
