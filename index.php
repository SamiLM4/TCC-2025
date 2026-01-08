<?php
require_once __DIR__ . "/vendor/autoload.php";

define('BASE_PATH', __DIR__);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require_once("modelo/Router.php");

$router = new Router();

/*
|--------------------------------------------------------------------------
| AUTH
|--------------------------------------------------------------------------
*/
$router->post("/api/auth/login", fn() =>
    require_once("controle/auth/Login.php")
);

$router->post("/api/auth/refresh", fn() =>
    require_once("controle/auth/refresh.php")
);

$router->post("/api/auth/logout", fn() =>
    require_once("controle/auth/logout.php")
);

$router->get("/api/auth/me", fn() =>
    require_once("controle/auth/me.php")
);

/*
|--------------------------------------------------------------------------
| USUÁRIOS
|--------------------------------------------------------------------------
*/

$router->get("/api/usuarios", fn() =>
    require_once("controle/usuario/UsuarioRead.php")
);

$router->get("/api/usuarios/(\d+)", fn($id) =>
    require_once("controle/usuario/UsuarioReadID.php")
);

$router->post("/api/usuarios", fn() =>
    require_once("controle/usuario/UsuarioCreate.php")
);

$router->put("/api/usuarios/(\d+)", fn($id) =>
    require_once("controle/usuario/UsuarioUpdate.php")
);

$router->delete("/api/usuarios/(\d+)", fn($id) =>
    require_once("controle/usuario/UsuarioDelete.php")
);

/*
|--------------------------------------------------------------------------
| Pepeis e permissoes
|--------------------------------------------------------------------------
*/

$router->get("/api/papeis", fn() =>
    require_once("controle/papel/PapelRead.php")
);

$router->get("/api/permissoes", fn() =>
    require_once("controle/papel/permissoes/PermissaoRead.php")
);

$router->post("/api/papeis", fn() =>
    require_once("controle/papel/PapelCreate.php")
);

$router->post("/api/papeis/(\d+)/permissoes", fn($id) =>
    require_once("controle/papel/permissoes/PermissaoCreate.php")
);

/*
|--------------------------------------------------------------------------
| Instituicoes
|--------------------------------------------------------------------------
*/

$router->get("/api/instituicoes", fn() =>
    require_once("controle/instituicao/InstituicaoRead.php")
);

$router->get("/api/instituicoes/(\d+)", fn($id) =>
    require_once("controle/instituicao/InstituicaoReadID.php")
);

$router->post("/api/instituicoes", fn() =>
    require_once("controle/instituicao/InstituicaoCreate.php")
);

$router->put("/api/instituicoes/(\d+)", fn($id) =>
    require_once("controle/instituicao/InstituicaoUpdate.php")
);

$router->delete("/api/instituicoes/(\d+)", fn($id) =>
    require_once("controle/instituicao/InstituicaoDelete.php")
);

/*
|--------------------------------------------------------------------------
| licencas
|--------------------------------------------------------------------------
*/

$router->post("/api/licencas", fn() =>
    require_once("controle/licenca/LicencaCreate.php")
);

$router->get("/api/licencas/(\d+)", fn($id) =>
    require_once("controle/licenca/LicencaReadID.php")
);

$router->post("/api/licencas/ativar", fn() =>
    require_once("controle/licenca/LicencaAtivar.php")
);

/*
|--------------------------------------------------------------------------
| administradores
|--------------------------------------------------------------------------
*/

$router->get("/api/admins", fn() =>
    require_once("controle/admin/AdminRead.php")
);

$router->get("/api/admins/(\d+)", fn($id) =>
    require_once("controle/admin/AdminReadID.php")
);

$router->post("/api/admins", fn() =>
    require_once("controle/admin/AdminCreate.php")
);

$router->put("/api/admins/(\d+)", fn($id) =>
    require_once("controle/admin/AdminUpdate.php")
);


$router->delete("/api/admins/(\d+)", fn($id) =>
    require_once("controle/admin/AdminDelete.php")
);

/*
|--------------------------------------------------------------------------
| MEDICOS
|--------------------------------------------------------------------------
*/
$router->get("/api/medicos", fn() =>
    require_once("controle/medico/MedicoRead.php")
);

$router->get("/api/medicos/(\d+)", fn($id) =>
    require_once("controle/medico/MedicoReadID.php")
);

$router->get("/api/medicos/crm/([^/]+)", fn($crm) =>
    require_once("controle/medico/MedicoReadCRM.php")
);

$router->post("/api/medicos", fn() =>
    require_once("controle/medico/MedicoCreate.php")
);

$router->put("/api/medicos/(\d+)", fn($id) =>
    require_once("controle/medico/MedicoUpdate.php")
);

$router->delete("/api/medicos/(\d+)", fn($id) =>
    require_once("controle/medico/MedicoDelete.php")
);

$router->post("/api/medicos/(\d+)/pacientes", fn($id) =>
    require_once("controle/medico/paciente/MedicoPacienteCreate.php")
);

$router->get("/api/medicos/(\d+)/pacientes", fn($id) =>
    require_once("controle/medico/paciente/MedicoPacienteRead.php")
);

$router->delete("/api/medicos/(\d+)/pacientes/(\d+)", fn($id, $idPaciente) =>
    require_once("controle/medico/paciente/MedicoPacienteDelete.php")
);

/*
|--------------------------------------------------------------------------
| PACIENTES
|--------------------------------------------------------------------------
*/

$router->get("/api/pacientes", fn() =>
    require_once("controle/paciente/PacienteRead.php")
);

$router->get("/api/pacientes/(\d+)", fn($id) =>
    require_once("controle/paciente/PacienteReadID.php")
);

$router->get("/api/pacientes/cpf/([^/]+)", fn($cpf) =>
    require_once("controle/paciente/PacienteReadCPF.php")
);

$router->post("/api/pacientes", fn() =>
    require_once("controle/paciente/PacienteCreate.php")
);

$router->put("/api/pacientes/(\d+)", fn($id) =>
    require_once("controle/paciente/PacienteUpdate.php")
);

$router->delete("/api/pacientes/(\d+)", fn($id) =>
    require_once("controle/paciente/PacienteDelete.php")
);

/*
|--------------------------------------------------------------------------
| IA
|--------------------------------------------------------------------------
*/

$router->post("/api/pacientes/(\d+)/ia", fn($id) =>
    require_once("controle/ia/IACreate.php")
);

$router->get("/api/pacientes/(\d+)/ia", fn($id) =>
    require_once("controle/ia/IARead.php")
);

$router->get("/api/ia/(\d+)/imagem", fn($id) =>
    require_once("controle/ia/IAReadimg.php")
);

$router->delete("/api/ia/(\d+)", fn($id) =>
    require_once("controle/ia/IADelete.php")
);

/*
|--------------------------------------------------------------------------
| menssagens
|--------------------------------------------------------------------------
*/

$router->post("/api/mensagens", fn() =>
    require_once("controle/mensagem/MensagemCreate.php")
);

$router->get("/api/mensagens/paciente/(\d+)", fn($id) =>
    require_once("controle/mensagem/MensagemReadPaciente.php")
);

$router->get("/api/mensagens/medico/(\d+)", fn($id) =>
    require_once("controle/mensagem/MensagemReadMedico.php")
);

/*
|--------------------------------------------------------------------------
| auditoria
|--------------------------------------------------------------------------
*/

$router->get("/api/auditoria", fn() =>
    require_once("controle/auditoria/AuditoriaRead.php")
);

$router->get("/api/auditoria/paciente/(\d+)", fn($id) =>
    require_once("controle/auditoria/AuditoriaReadPaciente.php")
);

$router->get("/api/auditoria/usuario/(\d+)", fn($id) =>
    require_once("controle/auditoria/AuditoriaReadUsuario.php")
);

/*
|--------------------------------------------------------------------------
| ANAMNESE (Ficha clínica do paciente)
|--------------------------------------------------------------------------
*/

/*
| Diagnósticos
*/
$router->get("/api/pacientes/(\d+)/diagnosticos", fn($pacienteId) =>
    require_once("controle/anamnese/diagnostico/DiagnosticoRead.php")
);

$router->post("/api/pacientes/(\d+)/diagnosticos", fn($pacienteId) =>
    require_once("controle/anamnese/diagnostico/DiagnosticoCreate.php")
);

$router->put("/api/diagnosticos/(\d+)", fn($id) =>
    require_once("controle/anamnese/diagnostico/DiagnosticoUpdate.php")
);

$router->delete("/api/diagnosticos/(\d+)", fn($id) =>
    require_once("controle/anamnese/diagnostico/DiagnosticoDelete.php")
);

/*
| Sintomas
*/
$router->get("/api/pacientes/(\d+)/sintomas", fn($pacienteId) =>
    require_once("controle/anamnese/sintomas/SintomasRead.php")
);

$router->post("/api/pacientes/(\d+)/sintomas", fn($pacienteId) =>
    require_once("controle/anamnese/sintomas/SintomasCreate.php")
);

$router->put("/api/sintomas/(\d+)", fn($id) =>
    require_once("controle/anamnese/sintomas/SintomasUpdate.php")
);

/*
| Histórico Médico
*/
$router->get("/api/pacientes/(\d+)/historico-medico", fn($pacienteId) =>
    require_once("controle/anamnese/historicoMedico/HistoricoMedicoRead.php")
);

$router->post("/api/pacientes/(\d+)/historico-medico", fn($pacienteId) =>
    require_once("controle/anamnese/historicoMedico/HistoricoMedicoCreate.php")
);

$router->put("/api/historico-medico/(\d+)", fn($id) =>
    require_once("controle/anamnese/historicoMedico/HistoricoMedicoUpdate.php")
);

/*
| Histórico Social
*/
$router->get("/api/pacientes/(\d+)/historico-social", fn($pacienteId) =>
    require_once("controle/anamnese/historicoSocial/HistoricoSocialRead.php")
);

$router->post("/api/pacientes/(\d+)/historico-social", fn($pacienteId) =>
    require_once("controle/anamnese/historicoSocial/HistoricoSocialCreate.php")
);

$router->put("/api/historico-social/(\d+)", fn($id) =>
    require_once("controle/anamnese/historicoSocial/HistoricoSocialUpdate.php")
);

/*
| Qualidade de Vida
*/
$router->get("/api/pacientes/(\d+)/qualidade-vida", fn($pacienteId) =>
    require_once("controle/anamnese/qualidadeVida/QualidadeVidaRead.php")
);

$router->post("/api/pacientes/(\d+)/qualidade-vida", fn($pacienteId) =>
    require_once("controle/anamnese/qualidadeVida/QualidadeVidaCreate.php")
);

$router->put("/api/qualidade-vida/(\d+)", fn($id) =>
    require_once("controle/anamnese/qualidadeVida/QualidadeVidaUpdate.php")
);

/*
| Exame Físico
*/
$router->get("/api/pacientes/(\d+)/exame-fisico", fn($pacienteId) =>
    require_once("controle/anamnese/exameFisico/ExameFisicoRead.php")
);

$router->post("/api/pacientes/(\d+)/exame-fisico", fn($pacienteId) =>
    require_once("controle/anamnese/exameFisico/ExameFisicoCreate.php")
);

$router->put("/api/exame-fisico/(\d+)", fn($id) =>
    require_once("controle/anamnese/exameFisico/ExameFisicoUpdate.php")
);

/*
| Exames Complementares
*/
$router->get("/api/pacientes/(\d+)/exames-complementares", fn($pacienteId) =>
    require_once("controle/anamnese/examesComplementares/ExamesComplementaresRead.php")
);

$router->post("/api/pacientes/(\d+)/exames-complementares", fn($pacienteId) =>
    require_once("controle/anamnese/examesComplementares/ExamesComplementaresCreate.php")
);

$router->put("/api/exames-complementares/(\d+)", fn($id) =>
    require_once("controle/anamnese/examesComplementares/ExamesComplementaresUpdate.php")
);

/*
| Plano de Tratamento
*/
$router->get("/api/pacientes/(\d+)/plano-tratamento", fn($pacienteId) =>
    require_once("controle/anamnese/planoTratamento/PlanoTratamentoRead.php")
);

$router->post("/api/pacientes/(\d+)/plano-tratamento", fn($pacienteId) =>
    require_once("controle/anamnese/planoTratamento/PlanoTratamentoCreate.php")
);

$router->put("/api/plano-tratamento/(\d+)", fn($id) =>
    require_once("controle/anamnese/planoTratamento/PlanoTratamentoUpdate.php")
);




$router->run();
