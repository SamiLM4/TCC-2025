<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require_once("modelo/Router.php");

$roteador = new Router();

// paciente

$roteador->get("/paciente/(\d+)", function ($pag) {

    require_once("controle/paciente/PacienteRead.php");
});


$roteador->get("/paciente/cpf/([^\/]+)", function ($valor) {
    require_once("controle/paciente/pacienteReadID.php");
});

$roteador->get("/paciente/(\d+)/diagnostico", function ($pag) {
    require_once("controle/paciente/pacienteReadDiagnostico.php");
});

$roteador->get("/paciente/filtrar/([^/]+)/diagnostico", function ($filtro) {
    require_once("controle/paciente/pacienteReadDIDiagnostico.php");
});

$roteador->post("/paciente", function () {

    require_once("controle/paciente/pacienteCadastrar.php");
});


$roteador->put("/paciente/(\d+)", function ($cpf) {

    require_once("controle/paciente/pacienteUpdate.php");
});


$roteador->delete("/paciente/(\d+)", function ($cpf) {

    require_once("controle/paciente/pacienteDelete.php");
});

// medico


$roteador->post("/medico/login", function () {

    require_once("controle/medico/medicoLogin.php");
});

$roteador->get("/medico/(\d+)", function ($pag) {

    require_once("controle/medico/medicoRead.php");
});

//
$roteador->get("/medico/gerarpacientes/(\d+)", function ($pag): void {
    require_once("controle/medico/medicoReadPacientes.php");
});

//

$roteador->get("/medico/cpf/(\d+)/(\d+)", function ($cpf, $pagina) {

    require_once("controle/medico/medicoReadCPF.php");
});

$roteador->get("/medico/crm/(\d+)", function ($crm) {

    require_once("controle/medico/medicoReadCRM.php");
});

$roteador->get("/medico/nome/([^/]+)", function ($nome) {
    require_once("controle/medico/medicoReadNome.php");
});

$roteador->get("/medico/filtro/([^/]+)", function ($filtro) {
    require_once("controle/medico/medicoReadFiltro.php");
});


$roteador->post("/medico", function () {

    require_once("controle/medico/medicoCadastrar.php");
});



$roteador->put("/medico/(\d+)", function ($cpf) {

    require_once("controle/medico/medicoUpdate.php");
});


$roteador->delete("/medico/(\d+)", function ($cpf) {

    require_once("controle/medico/medicoDelete.php");
});


// FICHA

$roteador->get("/ficha/(\d+)", function ($cpf) {
    require_once("controle/ficha/fichaRead.php");
});


$roteador->post("/ficha/(\d+)", function ($cpf) {
    require_once("controle/ficha/fichaCadastrar.php");
});

$roteador->put("/ficha/(\d+)", function ($id) {
    require_once("controle/ficha/fichaUpdate.php");
});


$roteador->delete("/ficha/(\d+)", function ($cpf) {
    require_once("controle/ficha/fichaDelete.php");
});

$roteador->post("/ficha/pdf", function () {
    require_once("controle/ficha/pdfFicha.php");
});

// ADM 

$roteador->post("/adm/login", function () {

    require_once("controle/administrador/administradorLogin.php");
});

$roteador->get("/adm/(\d+)", function ($pag) {

    require_once("controle/administrador/administradorRead.php");
});

$roteador->get("/adm/filtrar/([^/]+)", function ($filtro) {

    require_once("controle/administrador/administradorReadID.php");
});

$roteador->post("/adm", function () {

    require_once("controle/administrador/administradorCadastrar.php");
});

$roteador->put("/adm", function () {

    require_once("controle/administrador/administradorUpdate.php");
});

$roteador->delete("/adm/(\d+)", function ($id) {

    require_once("controle/administrador/administradorDelete.php");
});


// IA 


$roteador->post("/ia", function () {
    require_once("controle/ia/iaCadastrar.php");
});

$roteador->delete("/ia/(\d+)", function ($cpf) {
    require_once("controle/ia/iaDelete.php");
});

$roteador->get("/ia/(\d+)", function ($cpf) {
    require_once("controle/ia/iaRead.php");
});

$roteador->get("/ia/img/(\d+)", function ($cpf) {
    require_once("controle/ia/iaReadImg.php");
});
// PDF
/*
$roteador->get("/ficha/pdf/(\d+)", function ($cpf) {
    require_once("controle/ficha/fichaPDF.php");
});
*/
// MENSAGEM

$roteador->post("/mensagem/enviar/(\d+)", function ($cpf_medico) {
    require_once("controle/mensagem/mensagemEnviar.php");
});

$roteador->get("/mensagem/listar/(\d+)", function ($cpf_medico) {
    require_once("controle/mensagem/mensagemListar.php");
});

// INSTITUIÇÃO
$roteador->post("/instituicao", function () {
    require_once("controle/instituicao/instituicaoCadastrar.php");
});


// LICENÇA
$roteador->post("/licenca/comprar", function () {
    require_once("controle/licenca/licencaGerar.php");
});

/*
$roteador->get("/ficha/diagnostico/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});

$roteador->get("/ficha/examefisico/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});

$roteador->get("/ficha/examescomplementares/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});

$roteador->get("/ficha/historicomedico/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});

$roteador->get("/ficha/historicosocial/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});

$roteador->get("/ficha/planotratamento/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});

$roteador->get("/ficha/qualidadevidaem/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});

$roteador->get("/ficha/sintomas/(\d+)", function ($id) {
    require_once("controle/ficha/fichaReadID.php");
});
*/
/*
    // diagnostico

    $roteador->get("/diagnostico/(\d+)", function ($pagina) {

        require_once("controle/diagnostico/diagnosticoRead.php");
    });


    $roteador->get("/diagnostico/(\d+)", function ($id_a) {

        require_once("controle/diagnostico/diagnosticoReadID.php");
    });


    $roteador->post("/diagnostico", function () {

        require_once("controle/diagnostico/diagnosticoCadastrar.php");
    });



    $roteador->put("/diagnostico/(\d+)", function ($id_a) {

        require_once("controle/diagnostico/diagnosticoUpdate.php");
    });


    $roteador->delete("/diagnostico/(\d+)", function ($id_a) {

        require_once("controle/diagnostico/diagnosticoDelete.php");
    });

    // sintomas

    $roteador->get("/sintomas", function () {
        require_once("controle/sintomas/sintomasRead.php");
    });

    $roteador->get("/sintomas/(\d+)", function ($id) {
        require_once("controle/sintomas/sintomasReadID.php");
    });

    $roteador->post("/sintomas", function () {
        require_once("controle/sintomas/sintomasCadastrar.php");
    });

    $roteador->put("/sintomas/(\d+)", function ($id) {
        require_once("controle/sintomas/sintomasUpdate.php");
    });

    $roteador->delete("/sintomas/(\d+)", function ($id) {
        require_once("controle/sintomas/sintomasDelete.php");
    });


    // historico_medico

    $roteador->get("/historico_medico", function () {
        require_once("controle/historico_medico/historicoMedicoRead.php");
    });

    $roteador->get("/historico_medico/(\d+)", function ($id) {
        require_once("controle/historico_medico/historicoMedicoReadID.php");
    });

    $roteador->post("/historico_medico", function () {
        require_once("controle/historico_medico/historicoMedicoCadastrar.php");
    });

    $roteador->put("/historico_medico/(\d+)", function ($id) {
        require_once("controle/historico_medico/historicoMedicoUpdate.php");
    });

    $roteador->delete("/historico_medico/(\d+)", function ($id) {
        require_once("controle/historico_medico/historicoMedicoDelete.php");
    });


    // historico_social

    $roteador->get("/historico_social", function () {
        require_once("controle/historico_social/historicoSocialRead.php");
    });

    $roteador->get("/historico_social/(\d+)", function ($id) {
        require_once("controle/historico_social/historicoSocialReadID.php");
    });

    $roteador->post("/historico_social", function () {
        require_once("controle/historico_social/historicoSocialCadastrar.php");
    });

    $roteador->put("/historico_social/(\d+)", function ($id) {
        require_once("controle/historico_social/historicoSocialUpdate.php");
    });

    $roteador->delete("/historico_social/(\d+)", function ($id) {
        require_once("controle/historico_social/historicoSocialDelete.php");
    });


    // qualidade_vida_em

    $roteador->get("/qualidade_vida_em", function () {
        require_once("controle/qualidade_vida_em/qualidadeVidaRead.php");
    });

    $roteador->get("/qualidade_vida_em/(\d+)", function ($id) {
        require_once("controle/qualidade_vida_em/qualidadeVidaReadID.php");
    });

    $roteador->post("/qualidade_vida_em", function () {
        require_once("controle/qualidade_vida_em/qualidadeVidaCadastrar.php");
    });

    $roteador->put("/qualidade_vida_em/(\d+)", function ($id) {
        require_once("controle/qualidade_vida_em/qualidadeVidaUpdate.php");
    });

    $roteador->delete("/qualidade_vida_em/(\d+)", function ($id) {
        require_once("controle/qualidade_vida_em/qualidadeVidaDelete.php");
    });


    // exame_fisico

    $roteador->get("/exame_fisico", function () {
        require_once("controle/exame_fisico/exameFisicoRead.php");
    });

    $roteador->get("/exame_fisico/(\d+)", function ($id) {
        require_once("controle/exame_fisico/exameFisicoReadID.php");
    });

    $roteador->post("/exame_fisico", function () {
        require_once("controle/exame_fisico/exameFisicoCadastrar.php");
    });

    $roteador->put("/exame_fisico/(\d+)", function ($id) {
        require_once("controle/exame_fisico/exameFisicoUpdate.php");
    });

    $roteador->delete("/exame_fisico/(\d+)", function ($id) {
        require_once("controle/exame_fisico/exameFisicoDelete.php");
    });


    // exames_complementares

    $roteador->get("/exames_complementares", function () {
        require_once("controle/exames_complementares/examesComplementaresRead.php");
    });

    $roteador->get("/exames_complementares/(\d+)", function ($id) {
        require_once("controle/exames_complementares/examesComplementaresReadID.php");
    });

    $roteador->post("/exames_complementares", function () {
        require_once("controle/exames_complementares/examesComplementaresCadastrar.php");
    });

    $roteador->put("/exames_complementares/(\d+)", function ($id) {
        require_once("controle/exames_complementares/examesComplementaresUpdate.php");
    });

    $roteador->delete("/exames_complementares/(\d+)", function ($id) {
        require_once("controle/exames_complementares/examesComplementaresDelete.php");
    });


    // plano_tratamento

    $roteador->get("/plano_tratamento", function () {
        require_once("controle/plano_tratamento/planoTratamentoRead.php");
    });

    $roteador->get("/plano_tratamento/(\d+)", function ($id) {
        require_once("controle/plano_tratamento/planoTratamentoReadID.php");
    });

    $roteador->post("/plano_tratamento", function () {
        require_once("controle/plano_tratamento/planoTratamentoCadastrar.php");
    });

    $roteador->put("/plano_tratamento/(\d+)", function ($id) {
        require_once("controle/plano_tratamento/planoTratamentoUpdate.php");
    });

    $roteador->delete("/plano_tratamento/(\d+)", function ($id) {
        require_once("controle/plano_tratamento/planoTratamentoDelete.php");
    });
*/

$roteador->run();
?>