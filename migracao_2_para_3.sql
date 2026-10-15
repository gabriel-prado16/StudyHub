-- Use este arquivo se você já importou a versão com perfil e avaliações
-- (a anterior à de foto de perfil e respostas às respostas).
-- Se ainda estiver na primeira versão do fórum, rode antes o migracao_1_para_2.sql.
-- Quem está começando do zero deve importar apenas o schema.sql.
USE forum_escolar;

ALTER TABLE usuarios ADD COLUMN foto VARCHAR(255) NULL DEFAULT NULL;

CREATE TABLE comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resposta_id INT NOT NULL,
    usuario_id INT NOT NULL,
    texto VARCHAR(500) NOT NULL,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resposta_id) REFERENCES respostas(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);
