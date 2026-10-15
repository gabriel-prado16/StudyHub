-- Use este arquivo SOMENTE se você já tinha importado a versão anterior do schema.sql.
-- Quem está começando do zero deve importar apenas o schema.sql.
USE forum_escolar;

ALTER TABLE usuarios ADD COLUMN bio VARCHAR(255) NOT NULL DEFAULT '';

ALTER TABLE enquetes
    ADD COLUMN resultado ENUM('pendente','aprovada','rejeitada') NOT NULL DEFAULT 'pendente';

-- Enquetes já encerradas: aprovada se a matéria existe, senão rejeitada
UPDATE enquetes e
SET resultado = IF(EXISTS (SELECT 1 FROM categorias c WHERE c.nome = e.nome_categoria), 'aprovada', 'rejeitada')
WHERE e.ativa = 0;

CREATE TABLE avaliacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resposta_id INT NOT NULL,
    usuario_id INT NOT NULL,
    nota TINYINT NOT NULL,
    UNIQUE KEY uma_nota (resposta_id, usuario_id),
    FOREIGN KEY (resposta_id) REFERENCES respostas(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);
